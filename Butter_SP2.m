function [ylis,vlis,alis] = Butter_SP2(TPS,X,freacquis,frechoix,deg);

%[ylis,vlis,vbrute] = filtre_butter(TPS,X,freacquisnfrechoix,deg);
%
%Fonction int�gr�e au GUI principal de tracking
%Permet le calcul de donn�es filtr�es gr�ce � un filtre Butterworth 2
%
%Variables d'entr�e:
%   TPS: vecteur temps
%   X: donn�es � filtrer (n lignes, 1 colonne)
%   freacquis: fr�quence d'acquisition des donn�es
%   frechoix: Fr�quence de coupure
%   deg: Degr� du filtre
%
%Variables de sortie:
%   ylis: donn�es initiales filtr�es
%   vlis: donn�es filtr�es et d�riv�es une fois
%   vbrute: donn�es filtr�es et d�riv�es deux fois
%
%Fonction cr��e � partir de celle de Nicolas Houel
%
%Copyright (c), Marc Elipot
%Juin 2009



[nbligne,inutile] = size(X);
nbligneini = 1;
nblignefin = nbligne;

temps = TPS;
donne = X;


%%%%%%%%%CALCULS%%%%%%%%%%%%%%%
%Calcul de la fr�quence de coupure du filtre butterworth ou "fr�quence de
%coupure normalis�e de Nyquist"
frefiltre=frechoix/freacquis;
%cr�ation des coefficient du filtre butterworth (choix du degr� de filtrage
%et de la fr�quence de coupure (degr�, fr�quence)
[coefb,coefa] = butter(deg,frefiltre);
%cr�ation des donn�es liss�es � partir des coefficients du filtre
%butterworth et prise en compte du d�phasage grace � la fonction "filtfilt".
ylis= filtfilt(coefb,coefa,donne);
%Pr�sentation du graphique superposant les donn�es brutes et les donn�es
%liss�es.

alis = [];
[~,~,vlis,~] = spline2_SP2(ylis,freacquis);
%[c,yy,vbrute,abrute] = spline2_FFN(donne,freacquis);

