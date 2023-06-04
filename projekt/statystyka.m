clear all
clc
close all
%{
hist.J_best=[];
hist.K_opt=[];
hist.iterator=[];
hist.n=[];
save("history.mat","hist")
reset_nastawy
%}
for n=1:20
    save("n.mat","n")
    strojenie_wahadla_ackerman
    load("n.mat")
    load("history.mat")
    ost=length(hist.J_best);
    hist.n(ost+1) = n;
    hist.iterator(ost+1) =iterator;
    hist.K_opt(ost+1,:)=K_opt;
    hist.J_best(ost+1)=J_best;
    save("history.mat","hist")
end   

load("history.mat")
plot(hist.iterator,hist.J_best,'*')
xlabel("iteracje")
ylabel("wskaünik jakoúci regulacji")
grid on