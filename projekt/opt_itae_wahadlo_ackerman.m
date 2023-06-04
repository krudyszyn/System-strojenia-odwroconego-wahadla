function itae = opt_itae_wahadlo_ackerman(k)

 global J iterator K K_best minJ J_best wp wk wf

 wp=1;%waga sk≥adnika przemieszczenia
 wk=1;%waga sk≥adnika kata
 K=k;
 
 sim('odw_wahadlo_z_ackerman')
 itae=sum(wk*kat.^2+wp*przemieszczenie.^2+wf*F_generowana.^2); %wskaünik jakoúci regulacji
 J=itae; %wskaünik jakoúci
 iterator=iterator+1;
 
 %%%---przechwytywanie najlepszej otrzymanej iteracji----------------------
 
if J<minJ
     minJ=J;
     J_best=J; %
end

end
