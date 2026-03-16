function  [c,yy,vit,acc] = spline2_SP2(X,fe);


%[c,yy,vit,acc] = spline2(X,fe);
%
%Script permettant de r�pr�santer une s�rie de donn�es par une spline cubique.
%Ce script permet aussi deux d�rivations successives de l'�quation du spline (calcul de la vitesse et 
%de l'acc�l�ration � partir de la position par exemple).
%
%Variables d'entr�e:
%       TPS: Vecteur colonne temps
%       X: S�rie de donn�es � repr�senter
%       fe: fr�quence d'�chantillonnage
%
%Variables de sortie:
%       c: coefficient de chaque �l�ment du spline
%       vit: Donn�es ayant �t� d�riv�es 1 fois
%       acc: Donn�es ayant �t� d�riv�es 2 fois cons�cutivement
%
%Copyright (c), Marc Elipot
%F�vrier 2008.

c = [];
yy = [];
vit = [];
acc = [];

[n_ima,n_pts] = size(X);

TPS = 0:1/fe:(1/fe*(n_ima-1));
[n_ima2,n_pts2] = size(TPS);


fe = 1/fe;

if nargin < 2
    fprintf('Variables insuffisantes')
    return
end
%if n_ima ~= n_ima2
%    fprintf('X et TPS doivent avoir le m�me nombre de lignes')
%    return
%end

t = TPS;
for j = 1:n_pts
    %%%%Calcul le spline cubic puis restitue le donn�es dans la variable yy
    pp = csaps(t,X(:,j),1);
    yy = ppval(pp,t);

%    [VIT,ACC] = deriv2(X,fe);
    %%%%Calcul du d�riv� 1er degr� (vitesse) du spline �l�ment par �l�ment:
    xs = [zeros(1,n_ima-1) fe];
    c = pp.coefs;

    a = xs(1,1:n_ima-1)';
    vit(1:n_ima-1,j) = ((3.*(a.^2)).*c(1:n_ima-1,1))+(2.*a.*c(1:n_ima-1,2))+(c(1:n_ima-1,3));
        
    a = xs(1,n_ima);
    vit(n_ima,j) = ((3.*(a.^2)).*c(n_ima-1,1))+(2.*a.*c(n_ima-1,2))+(c(n_ima-1,3));
    %%%%Interpolation de la vitesse lors de la derni�re image:
    
%    vit(n_ima,j) = VIT(n_ima,j);
    
    %%%%Interpolation de la vitesse lors de la derni�re image:
%    acc(n_ima,j) = ACC(n_ima,j);
end