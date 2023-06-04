clear all
close all
clc

%%%----dane----------------------------------------------------------------
dane

disp("Masa wahadla: "+num2str(m)+"kg")
disp("Masa wozka: "+num2str(M)+"kg")
disp("Odleglosc sr. ciezkosci: "+num2str(L)+"m")
disp("Wspol. tarcia wiskotycznego: "+num2str(b)+"Ns/m")
disp(" ")
%%%---model w przestrzeni stan�w-------------------------------------------
rownania_stanu_wahadla_odw

%%%---sprawdzenie sterowalnosci i obserwowalnosci--------------------------
rz_sterowalnosci = rank(ctrb(A,B));
if rz_sterowalnosci==4
    disp('uklad sterowalny')
else
    disp('uklad niesterowalny')
end

%%----macierze wag---------------------------------------------------------
waga=load('wagi.mat');%odczyt wag z pliku mat
wk=waga.wk; %waga po�o�enia k�towego
wp=waga.wp; %waga po�o�enia liniowego
wf=waga.wf; %waga si�y generowanej

Q = diag([0 wk 0 wp]);
R = wf;

disp("Wagi regulatora LQR")
disp("przemieszczenie liniowe: "+num2str(wp))
disp("przemieszczenie katowe: "+num2str(wk))
disp("sila napedu: "+num2str(wf))
disp(" ")
%%%---wektor wzmocnie�-----------------------------------------------------
K_lqr = lqr(A,B,Q,R);
disp("macierz wzmocnien K: "+ num2str(K_lqr))
bieguny_zam=eig(A-B*K_lqr);%kontrolne sprawdzenie biegun�w uk�adu zamkni�tego

%%%---zapis nastaw K_opt do pliku mat--------------------------------------
save('nastawy_lqr.mat','K_lqr')
