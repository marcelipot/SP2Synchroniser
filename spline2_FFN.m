function  [c,yy,vit,acc] = spline2_FFN(X,fe);


%[c,yy,vit,acc] = spline2(X,fe);
%
%Script permettant de réprésanter une série de données par une spline cubique.
%Ce script permet aussi deux dérivations successives de l'équation du spline (calcul de la vitesse et 
%de l'accélération à partir de la position par exemple).
%
%Variables d'entrée:
%       TPS: Vecteur colonne temps
%       X: Série de données à représenter
%       fe: fréquence d'échantillonnage
%
%Variables de sortie:
%       c: coefficient de chaque élément du spline
%       vit: Données ayant été dérivées 1 fois
%       acc: Données ayant été dérivées 2 fois consécutivement
%
%Copyright (c), Marc Elipot
%Février 2008.

[n_ima,n_pts] = size(X);

TPS = 0:1/fe:(1/fe*(n_ima-1));
[n_ima2,n_pts2] = size(TPS);


fe = 1/fe;

if nargin < 2
    fprintf('Variables insuffisantes')
    return
end
%if n_ima ~= n_ima2
%    fprintf('X et TPS doivent avoir le même nombre de lignes')
%    return
%end

t = TPS;
for j = 1:n_pts
    %%%%Calcul le spline cubic puis restitue le données dans la variable yy
    pp = csaps(t,X(:,j),1);
    yy = ppval(pp,t);

%    [VIT,ACC] = deriv2(X,fe);
    %%%%Calcul du dérivé 1er degré (vitesse) du spline élément par élément:
    xs = [zeros(1,n_ima-1) fe];
    c = pp.coefs;
    for i = 1:n_ima
        a = xs(1,i);
        if i ~= n_ima
            vit(i,j) = ((3.*(a.^2)).*c(i,1))+(2.*a.*c(i,2))+(c(i,3));
        elseif i == n_ima
            vit(i,j) = ((3.*(a.^2)).*c(i-1,1))+(2.*a.*c(i-1,2))+(c(i-1,3));
        end
    end
    %%%%Interpolation de la vitesse lors de la dernière image:
    
%    vit(n_ima,j) = VIT(n_ima,j);
    
    %%%%Calcul du dérivé 2nd degré (accélération) du spline élément par
    %%%%élément:
    for i = 1:n_ima
        a = xs(1,i);
        if i ~= n_ima
            acc(i,j) = ((6.*a).*c(i,1))+(2.*c(i,2));
        elseif i == n_ima
            acc(i,j) = ((6.*a).*c(i-1,1))+(2.*c(i-1,2));
        end
    end
    %%%%Interpolation de la vitesse lors de la dernière image:
%    acc(n_ima,j) = ACC(n_ima,j);
end