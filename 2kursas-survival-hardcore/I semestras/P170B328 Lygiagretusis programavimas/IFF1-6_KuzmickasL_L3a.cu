#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <cstdio>
#include <iostream>
#include <fstream>
#include <nlohmann/json.hpp>
#include <iomanip> 
#include <locale>
#include <codecvt>

using json = nlohmann::json;

#define THREAD_COUNT 64
#define BLOCK_COUNT 2

struct Student {
    std::string name;
    int year;
    float grade;
};

bool compareStudentsByGrade(const Student& a, const Student& b) {
    return a.grade > b.grade;
}

void writeOutputToFile(const std::string& filename, const Student* h_students, const bool* h_filter, int dataSize) {
    std::ofstream outputFile(filename);
    if (outputFile.is_open()) {
        outputFile << "Filtruoti duomenys" << std::endl;
        outputFile << "\n";
        std::vector<Student> sortedStudents;
        for (int i = 0; i < dataSize; ++i) {
            if (h_filter[i]) {
                sortedStudents.push_back(h_students[i]);
            }
        }
        std::sort(sortedStudents.begin(), sortedStudents.end(), compareStudentsByGrade);
        for (const auto& student : sortedStudents) {
            if (student.grade > 75 && student.grade < 80) {
                outputFile << student.name << " C" << std::endl;
            }
            else if (student.grade >= 80 && student.grade < 90) {
                outputFile << student.name << " B" << std::endl;
            }
            else if (student.grade >= 90) {
                outputFile << student.name << " A" << std::endl;
            }
        }
        outputFile.close();
    }
    else {
        std::cerr << "Error opening output file: " << filename << std::endl;
    }
}


void parseJson(const std::string& filename, Student* students, int* dataSize) {
    std::ifstream file(filename);
    if (!file.is_open()) {
        std::cerr << "Error opening file: " << filename << std::endl;
        exit(EXIT_FAILURE);
    }
    json jsonData;
    file >> jsonData;
    if (!jsonData.is_object() || !jsonData.contains("students") || !jsonData["students"].is_array()) {
        std::cerr << "Error: 'students' array not found in JSON file" << std::endl;
        exit(EXIT_FAILURE);
    }
    auto studentsArray = jsonData["students"];
    *dataSize = std::min(static_cast<int>(studentsArray.size()), *dataSize);
    for (int i = 0; i < *dataSize; ++i) {
        auto studentJson = studentsArray[i];
        if (!studentJson.contains("name") || !studentJson["name"].is_string() ||
            !studentJson.contains("year") || !studentJson["year"].is_number() ||
            !studentJson.contains("grade") || !studentJson["grade"].is_number()) {
            std::cerr << "Error: Invalid data format in JSON file" << std::endl;
            exit(EXIT_FAILURE);
        }
        students[i].name = studentJson["name"].get<std::string>();
        students[i].year = studentJson["year"].get<int>();
        students[i].grade = studentJson["grade"].get<float>();
    }
}


__global__ void filterStudents(const Student* inputStudents, bool* outputFilter, int dataSize, float threshold) {

    int elementsPerBlock = dataSize / BLOCK_COUNT - (dataSize / BLOCK_COUNT % THREAD_COUNT);
    int start = elementsPerBlock * blockIdx.x;
    int end = start + elementsPerBlock;
    if (blockIdx.x == BLOCK_COUNT - 1) {
        end = dataSize;
    }
    for (int i = start + threadIdx.x; i < end; i += THREAD_COUNT) {
        if (i % THREAD_COUNT == threadIdx.x) {
            outputFilter[i] = inputStudents[i].grade >= threshold;
        }
    }
}

int main() {
    const std::string filename = "L3.json";
    const int maxStudents = 250;
    int dataSize = maxStudents;
    const int blockSize = 32;
    const int gridSize = (dataSize + blockSize - 1) / blockSize;
    Student h_students[maxStudents];
    parseJson(filename, h_students, &dataSize);
    std::cout << "Skaitomas json failas: " << filename << std::endl;
    Student* d_students;
    bool* d_filter;
    cudaMalloc((void**)&d_students, dataSize * sizeof(Student));
    cudaMalloc((void**)&d_filter, dataSize * sizeof(bool));
    cudaMemcpy(d_students, h_students, dataSize * sizeof(Student), cudaMemcpyHostToDevice);
    // filtravimo sąlyga
    float threshold = 70.0;
    filterStudents << <gridSize, blockSize >> > (d_students, d_filter, dataSize, threshold);
    cudaDeviceSynchronize();
    bool h_filter[maxStudents];
    cudaMemcpy(h_filter, d_filter, dataSize * sizeof(bool), cudaMemcpyDeviceToHost);
    writeOutputToFile("islaike_studentai.txt", h_students, h_filter, dataSize);
    std::cout << "Duomenys sėkmingai sufiltruoti" << std::endl;
    cudaFree(d_students);
    cudaFree(d_filter);
    std::cout << "Atlaisvinama atmintis " << std::endl;
    return 0;
}
