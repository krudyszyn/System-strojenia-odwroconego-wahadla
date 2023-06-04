%clear all
close all
clc

%%%----dane----------------------------------------------------------------
dane

disp("Masa wahadla: "+num2str(m)+"kg")
disp("Masa wozka: "+num2str(M)+"kg")
disp("Odleglosc sr. ciezkosci: "+num2str(L)+"m")
disp("Wspol. tarcia wiskotycznego: "+num2str(b)+"Ns/m")
disp(" ")
%%%---wektor wzmocnien----------------------------------------------------
regulator=load('typ_regulatora.mat');%odczyt typu regulatora
typ_regulator=regulator.typ_regulator;

if typ_regulator==1
    nastawy=load('nastawy.mat');%odczyt zoptymalizowanego wektora wzmocnien z pliku nastawy.mat
    K=nastawy.K_best;
    disp("typ regulatora: strojony numerycznie")
else
    nastawy_lqr=load('nastawy_lqr.mat');%odczyt zoptymalizowanego wektora wzmocnien z pliku nastawy_lqr.mat
    K=nastawy_lqr.K_lqr;
    disp("typ regulatora: LQR")
end

%%%---sterowanie symulacj¹-------------------------------------------------
T_symulacji=50; %czas symulacji
t_krok=0.005; %krok czasowy symulacji
czas=(0:t_krok:T_symulacji)'; %wektor czasu

%%%---zaklocenia-----------------------------------------------------------
zaklocenia
F_zaklocajaca_sim = [czas, F_zaklocajaca];

%%%---symulacja------------------------------------------------------------
sim("odw_wahadlo_z_ackerman");

%%%---wykresy--------------------------------------------------------------
figure(1)
plot(czas,F_zaklocajaca)
hold on
plot(czas,F_generowana)
hold off
%axis([0 50 -2 2])
title('zak³ócenie vs reakcja uk³adu')
legend('si³a wytracajaca wahadlo z polozenia rownowagi','sila napedu odwroconego wahad³a')
xlabel('czas [s]')
ylabel('si³a [N]')
grid on

figure(2)
plot(czas,przemieszczenie)
title('przemieszczenie wózka odwroconego wahadla')
xlabel('czas [s]')
ylabel('przemieszczenie [m]')
grid on

figure(3)
plot(czas,180/pi*kat)
title('kat wychylenia odwroconego wahad³a')
xlabel('czas[s]')
ylabel('kat wychylenia [stopnie]')
grid on