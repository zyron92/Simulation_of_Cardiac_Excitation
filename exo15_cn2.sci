//Appeler la fonction slaplacien
exec('exo7_slaplacien.sci',-1)

function[e_etoile]=cn2(e_mid,dt,D,n,L)

	A = L .* (-dt/2) + eye(n*n,n*n)
	b = ( L .* (dt/2) + eye(n*n,n*n))*e_mid
	
	//factorisation ALU
	A = sparse(A)
	Lu_mat = umf_lufact(A);

	//résoudre Ax=e_etoile
	e_etoile = umf_lusolve(Lu_mat,b)

	//libère la mémoire
	umf_ludel(Lu_mat)

endfunction

//-- L'exemple --//
//D=1  	//Constant conductivité
//n=2 	//Taille de grille
//dt=2 	//Pas de temps

//--les vecteurs (condition) initiaux de taille n*n et matrice L qu'on a choisi ; ici n=2
//e_mid=[1,0,1,0]'

//--affiche les valeurs de e*
//L=slaplacien(D,n);
//[e_etoile]=cn2(e_mid,dt,D,n,L)
