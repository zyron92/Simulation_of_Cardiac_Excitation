function[res]=laplacien(D,n)
if n>1 then
    
    h=1/(n-1)
   
    //Définir T1 & Tn
    T1=-3*eye(n,n)+diag(ones(n-1,1),1)+diag(ones(n-1,1),-1)
    T1(1,1)=T1(1,1)+1
    T1(n,n)=T1(n,n)+1
    T1=(1/(h*h))*T1
    
    //Définir Tk
    Tk=-4*eye(n,n)+diag(ones(n-1,1),1)+diag(ones(n-1,1),-1)
    Tk(1,1)=Tk(1,1)+1
    Tk(n,n)=Tk(n,n)+1
    Tk=(1/(h*h))*Tk

    //Définir A
    A=zeros(n*n,n*n)+(1/(h*h))*diag(ones(n*(n-1),1),n)+(1/(h*h))*diag(ones(n*(n-1),1),-n)
    
    k=1
    
    //Affecter les T1
    i= indice_i(k,n)
    j= indice_j(k,n)
    A([ i : j ],[ i : j ])=T1
    
    k=k+1
    
    //Affecter les Tk
    while(k<=n-1),
        i= indice_i(k,n)
        j= indice_j(k,n)
        A([ i : j ],[ i : j ])=Tk
        k=k+1
    end
    
    //Affecter les T1 au bout de k=n => Tn
    if k==n then
        i= indice_i(k,n)
        j= indice_j(k,n)
        A([ i : j ],[ i : j ])=T1
    end
    
    //Renvoyer la matrice résultante de (n*n ; n*n)
    res=D.*A
    
else
    
    res=0
    
end
endfunction

//Calcul de l'indice i de sous-matrice
function[res]=indice_i(k,n) 
    res=(n*(k-1))+1
endfunction

//Calcul de l'indice j de sous-matrice
function[res]=indice_j(k,n) 
    res=k*n
endfunction

//-- L'Exemple --//
//n=3
//D=2
//res=laplacien(D,n)
