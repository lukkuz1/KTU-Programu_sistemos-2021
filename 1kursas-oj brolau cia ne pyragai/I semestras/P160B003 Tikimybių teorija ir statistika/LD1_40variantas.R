#1 UŽDUOTIS
N=40         #varianto numeris
data=read.csv('duomenys_hipoteziu_tikrinimui.csv', header=TRUE)
data = data[1:1000,N]
data
#1.1. Raskite skaitines imties charakteristikas: imties dydį, 
#minimumą, maksimumą, imties plotį, kvartilius,
#kvartilių skirtumą (IQR), empirinį vidurkį, 
#pataisytąją dispersiją, pataisytąjį standartinį nuokrypį.

n = length(data)
#Imties dydis
n
data_minimum = min(data)
#Minimumas
data_minimum
data_maximum = max(data)
#Maximumas
data_maximum
#imties plotis
data_plot = diff(range(data))
data_plot
#kvartiliai
quantile(data, c(0.25, 0.5, 0.75), type = 2)
#Kvartiliu skirtumas
KP <- IQR(data)
KP
#Empirinis vidurkis
emp_vidurkis = mean(data)
emp_vidurkis
#Pataisytoji dispersija
disp_pat <- var(data)
disp_pat
#Pataisytasis standartinis nuokrypis
standartas_pat <- sd(data)
standartas_pat
#1.2. Nubraižykite histogramą ir stačiakampę diagramą. 
#Pagal gautus grafikus, parinkite vieną iš trijų tolydžiųjų
#skirstinių (normalųjį, eksponentinį arba tolygųjį), 
#kuris galėtų geriausiai tikti duotiesiems duomenims.

#Stačiakampe diagrama
boxplot(data, horizontal = TRUE, main = "Stačiakampė diagrama")
k <- ceiling(log10(length(data))*3.32+1)
k
#Histograma
hist(data, breaks = seq(min(data), max(data),length = k+1),
     probability = T,
     right = F,
     col = grey(0.9),
     ylab = "Santykiniai dažniai",
     main = "Histograma"
)




#Geriausiai tinka tolygusis skirstinys.
#1.3. Raskite skirstinio parametrų taškinius įverčius.
#Taškiniai įverčiai - didžiausio tikėtumo metodas
#Tolydaus skirstinio taškiniai įverčiai


a = floor(min(data))
b = ceiling(max(data))
a
b
k <- ceiling(log10(length(data))*3.32+1)
k
bin = seq(a, b, length.out = k+1)
bin
k = k - 1
bin1 = c(a, bin[2:k], b)
bin1
p = c(punif(bin1[1:k+1],a,b) - punif(bin1[0:k],a,b))
p
sum(p)
p


#1.4. Suformuluokite ir patikrinkite atitinkamą suderinamumo hipotezę 
#(reikšmingumo lygmenį α pasirinkite patys).
#Užrašykite nagrinėjamo populiacijos požymio skirstinio funkciją.
#Taikydami Kolmogorovo kriterijų patikriname hipotezę, 
#kad duomenys pasiskirstę pagal tolygųjį dėsnį
a = -2
b = 7.2
# Surašome duomenis į variacinę eilutę:
data = sort(data)
data
n = length(data)
# Apskaičiuojame pasiskirstymo funkcijos reikšmes:
FoX = punif(data, a, b)
FoX
# Tarpiniai skaičiavimai Kolmogorovo statistikai D_n apskaičiuoti:
FnX = seq(1:n)/n       # i/n
Fn1X = (seq(1:n)-1)/n  # (i-1)/n
# Apskaičiuojame skirtumus su teorine funkcija. 
Dp = FnX - FoX
Dm = FoX - Fn1X
# Suformuojame tarpinių rezultatų lentelę:
Lentele = cbind(data, FnX, Fn1X, FoX, Dp, Dm)
Lentele
# Iš lentelės išrenkame D_n^+ ir D_n^- reikšmes DP ir DM: 
DP = max(Dp)
DP
DM = max(Dm)
DM
# Apskaičiuojame Kolmogorovo statistikos D_n reikšmę Dn:
Dn = max(DP,DM)
Dn
# Apibrėžiame reikšmingumo lygmenį alpha.
alpha = 0.05 
# Pagal apytikslę formulę apskaičiuojame Kolmogorovo skirstinio kvantilį k:
k = sqrt(-log(alpha/2)/(2*n))-1/(6*n)
k
#Kadangi 0.03022493 < 0.04278027, galime teigti, kad atsitiktinis dydis 
# pasiskirstęs pagal tolygųjį dėsnį, neprieštarauja imties duomenims.
#SKIRSTINIO FUNKCIJA ?????
#f(x) = ??? n(imties dydis, kurios mazesnes uz x) / n(imties dydis)
dnorm(data, emp_vidurkis, standartas_pat)


#2 DALIS
N=40 #varianto numeris
data=read.csv('normalusis_parametru_iverciams.csv', header=TRUE)
pasikliovimo_lygmuo = data[1,N]
data = data[2:1001,N]
data
#2.1. Nubraižykite histogramą, stačiakampę diagramą ir kvantilinį grafiką (Q-Q plot).
#Parašykite, kokios šių grafikų savybės rodo, 
#kad nagrinėjamo atsitiktinio dydžio skirstinys yra normalusis (po vieną savybę iš kiekvieno grafiko).
#vidurkio, modos ir medianos reikšmės sutampa
boxplot(data, horizontal = TRUE, main = "Stačiakampė diagrama")

k <- ceiling(log10(length(data))*3.32+1)
k
#skirstinio tikimybių pasiskirstymo kreivė yra dvipusiai simetriška, o simetrijos ašis yra ties vidurkiu
#Histograma
hist(data, breaks = seq(min(data), max(data),length = k+1),
     probability = T,
     right = F,
     col = grey(0.9),
     ylab = "Santykiniai dažniai",
     main = "Histograma"
)
##QQ diagramos išsidėstymas panašus į tiesę
library(UsingR)
simple.eda(data)


#2.2. Raskite taškinius vidurkio ir dispersijos įverčius.
n=length(data)
Xvid = mean(data)
Xvid
disp = ((n-1)/n)*var(data)
install.packages("MASS")
library(MASS)
iverciai <- fitdistr(data,"normal")
#Vidurkio iverciai
iverciai
#Dispersija
disp

#2.3. Sudarykite parametrų pasikliautinuosius intervalus su pasikliovimo lygmeniu γ=1- α. Parašykite po vieną
#išvadą apie populiacijos parametro intervalinį įvertį.
#DISPERSIJA YRA ŽINOMA
n = length(data)
n
Xvid = mean(data)
Xvid
pasikliovimo_lygmuo
#Kvantilis
zp = qnorm(pasikliovimo_lygmuo)
zp
#Intervalinis įvertis (Teorinės formulės naudojimas)
PI <- c(Xvid-disp*zp/sqrt(n),Xvid+disp*zp/sqrt(n))
PI
#Populiacijos parametro intervalas atitinka teorines reikšmes

#2.4. Suformuluokite ir patikrinkite hipotezę apie vidurkio lygybę skaičiui m0 su alternatyviąja hipoteze:
#1) Ha : m≠ m0 ir reikšmingumo lygmeniu α, kai varianto numeris yra lyginis skaičius;
#2) Ha : m> m0 ir reikšmingumo lygmeniu α, kai varianto numeris yra pirminis skaičius;
#3) Ha : m< m0 ir reikšmingumo lygmeniu α, kai varianto numeris yra nelyginis ir nepirminis.
#1 variantas m0 = 3.2, varianto numeris = 40
#1 variantas - 40 yra lyginis skaičius.
N=40 #varianto numeris
data=read.csv('normalusis_parametru_iverciams.csv', header=TRUE)
pasikliovimo_lygmuo = data[1,N]
data = data[2:1001,N]
data
m0 = 3.2 #skaičius paimtas iš intervalinio įverčio reikšmių
install.packages("UsingR")
library(UsingR)
library(datasets)
data(msleep)
attach(msleep)
#p reikšmė yra mažesnė už reikšmingumo lygmenį, 2.2e-16 < 0.95, todėl
#galime atmesti nulinę hipotezę, kad vidutinė reikšmė yra lygi 3.2. Galime teigti jog ši reikšmė statistiškai skiriasi nuo 3.2
t.test(sleep_total, mu = m0, conf.level = 0.95, alternative = 'two.sided')
detach(msleep)
