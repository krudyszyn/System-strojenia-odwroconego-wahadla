clear all
clc
close all

load('history.mat')
load('nastawy.mat')
load('typ_zaklocenia.mat')

figure(10)
semilogy(hist.iterator, hist.J_best,'*')
xlabel("iteracje")
ylabel("wskaünik jakoúci regulacji")
title("strojenie - szum gaussowski")
grid on
axis([350 820 25 160])

%{
n=0;

for j=1:20
  if hist.J_best(j)==min(hist.J_best);
      n=j;
  end
end
J_best=hist.J_best(16)
K_best=hist.K_opt(16,:)
save("nastawy.mat","K_best","J_best")
%}