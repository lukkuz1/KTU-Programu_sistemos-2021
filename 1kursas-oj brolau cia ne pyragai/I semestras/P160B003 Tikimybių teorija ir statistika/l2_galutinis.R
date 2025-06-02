#1 DALIS
#Kuzmickas Lukas IFF-1/6
#30 variantas
N = 30 #Reikia įrašyti savo varianto numerį N
data=read.csv('duomenys_Pirsono_koreliacijos_koeficientui.csv',header=TRUE) #Failas turi būti darbiniame
x1=data[,2*(N-1)+1]
y1=data[,2*N]
x1
y1
#1.1. Pateikite x1 vs. y1 grafiką ir pakomentuokite priklausomybę tarp šių kintamųjų.
plot(x1,y1)
#Iš grafiko pastebime, kad x1 didėjant, y1 irgi didėja - galime teigti, jog tai tiesinė priklausomybė.




#1.2. Apskaičiuokite Pirsono koreliacijos koeficientą tarp kintamųjų x1 ir y1. Pateikite koeficiento reikšmės
#interpretaciją savo duomenų imties atveju.
cor(x1,y1, method="pearson")
#Pirsono koreliacijos koeficientas = 0.6636055, ryšys tarp x1 ir y1 yra vidutinis.




#2 DALIS
N = 30 #Reikia įrašyti savo varianto numerį N
data=read.csv('duomenys_Spirmeno_koreliacijos_koeficientui.csv',header=TRUE) #Failas turi būti darbiniame
x2=data[,2*(N-1)+1]
y2=data[,2*N]
x2
y2
#1.3. Pateikite x2 vs. y2 grafiką ir pakomentuokite priklausomybę tarp šių kintamųjų.
plot(x2, y2)
#Iš grafiko matome, kad priklausomybė yra pusiau tiesiška, priklausomybės pilnai nustatyti negalime.






#1.4. Apskaičiuokite Spirmeno koreliacijos koeficientą tarp kintamųjų x2 ir y2. Pateikite koeficiento reikšmės
#interpretaciją savo duomenų imties atveju.
spearmancor = cor(x2, y2, method = "spearman")
spearmancor
#Spirmeno koreliacijos koeficientas = 0.9557525, ryšys tarp x2 ir y2 yra labai stiprus.



#3 DALIS
variantas= 30 #Reikia įrašyti savo varianto numerį
data=read.csv('duomenys_regresijai.csv',header=TRUE) #Failas turi būti darbiniame kataloge
x=data[,2*(variantas-1)+1]
y=data[,2*variantas]
y
x
#2.1. Pateikite x vs. y grafiką ir pakomentuokite priklausomybę tarp šių kintamųjų.
plot(x,y)
#Iš grafiko matome, kad ryšys tarp duomenų yra pastovus - linijinis, išvados apie priklausomybe padaryti negalime





#2.2. Apskaičiuokite Pirsono koreliacijos koeficientą ir pakomentuokite jo reikšmę.
cor(x, y, method = "pearson")
#Pirsono koreliacijos koeficientas r = 0.5041774, ryšys tarp x ir y yra vidutinis.






#2.3. Apskaičiuokite tiesinės regresijos koeficientus ir juos pateikite. Parašykite vieną išvadą apie koeficientų
#reikšmę ir ryšį tarp kintamųjų x,y.
reg = lm(y~x)
plot(x,y)
lines(x, predict(reg))
reg
#Gavome a = 5.7601
#b = 0.9374
#Regresijos lygtis: Y = 5.7601+0.9374x
#Iš regresijos lygties galime daryti išvada, kad tarp x ir y yra tiesinė priklausomybė.







#2.4. Apskaičiuokite determinacijos koeficientą tiesinės regresijos modeliui, gautam 2.3 punkte.
deterKoeficientas = summary(reg)
deterKoeficientas
#Rsquared = 0.2543, determinacijos koeficientas.






#2.5. Pateikite jūsų gauto modelio prognozę vienai pasirinktai x reikšmei.
#pasirinkta x reikšmė 1
yPrognoze = predict(reg, data.frame(x=1))
yPrognoze
#Gauname modelio prognozę y_pr = 6.6975, kai x = 1





#2.6. Pateikite modelio liekanų grafiką ir histogramą. Pakomentuokite, ar vizualiai galima teigti, jog liekanos yra
#pasiskirstę pagal normalųjį skirstinį su vidurkiu, lygiu nuliui?
paklaidos <- residuals(reg)
plot(paklaidos)
mean(paklaidos)
h <- hist.default(paklaidos)
#Iš liekanų grafiko ir histogramos galime vizualiai teigti, jog liekanos yra pasiskirsčiusios pagal normalųjį skirstinį.








#2.7. Patikrinkite hipotezę (alpha = 0.05), kad tiesinės regresijos liekanų skirstinys yra normalusis, kurio vidurkis
#lygus 0.
alpha = 0.05
# Kolmogrovo-Smirnofo kriterijus
install.packages('EnvStats')
library(EnvStats)
gof.list <- gofTest(paklaidos, test = "ks", distribution = "norm",param.list = list(mean = 0, sd = sd(paklaidos)), keep.data =  F)
gof.list
#gauta p reikšmė = 0.8178942, p > alpha, todėl hipotezė, kad liekanos yra pasiskirsčiusios pagal normalųjį skirstinį su vidurkiu, lygiu nuliui pasitvirtino

#Antrasis metodas
ks.test(paklaidos, "pnorm", 0, sd(paklaidos))
#gauta p reikšmė p = 0.8179, p > alpha, todėl hipotezė, kad liekanos yra pasiskirsčiusios pagal normalųjį skirstinį su vidurkiu, lygiu nuliui pasitvirtino







# koeficientas tarp 0 ir 0.3 - tiesinis ryšys, labai silpnas
# koeficientas tarp 0.3 ir 0.5 - silpnas
# koeficientas tarp 0.5 ir 0.7 - vidutinis
# koeficientas tarp 0.7 ir 0.9 - stiprus
# koeficientas tarp 0.9 ir 1 - labai stiprus
# su neigiamais simetriškai taip pat, tik vadinamas teigiamas arba neigiamas ryšys

