%%%---zaklocenia-----------------------------------------------------------

load('typ_zaklocenia.mat'); %wczytanie zmiennej steruj¹cej 

switch typ_zaklocen
    case 1
        %wymuszenie impulsowe
        F_zaklocajaca=zeros(length(czas),1); %sila probujaca wytracic wahadlo z rownowagi
        for j=1:length(F_zaklocajaca)
            if czas(j)>0 & czas(j)<0.011
                F_zaklocajaca(j)=1;
            end
        end
    case 2
        %wymuszenie skokowe
        F_zaklocajaca=1*ones(length(czas),1); %sila probujaca wytracic wahadlo z rownowagi
        for j=1:length(F_zaklocajaca)
            if (czas(j)>0 & czas(j)<0.011)
               F_zaklocajaca(j)=0;
            end
        end
    case 3
       F_zaklocajaca=wgn(length(czas),1,1); %sila probujaca wytracic wahadlo z rownowagi
    case 4
       czestotliwosc=1; %czestotliwosc w Hz 
       F_zaklocajaca=sin(2*pi*czestotliwosc*czas); %sila probujaca wytracic wahadlo z rownowagi
end
