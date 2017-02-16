//appeler la fonction qui résout le problème modèle cellulaire
exec('exo4_modele_cell.sci',-1)

//la fonction qui initialise la grille avec des zéros
function[res_e,res_r]=initialise_grille(n,e0,r0)
	res_e=zeros(n*n,1)+e0
	res_r=zeros(n*n,1)+r0
endfunction

//Afichage en matrice (Mij, j suit x, i suit y)
function[M_e,M_r]=affiche_matrice(e,r,n)
	M_e = matrix(e,n,n)
	M_r = matrix(r,n,n)
endfunction

//la fonction principale qui initialise tout
function main_initialise(T,t0,dt,e0,r0,n)

	//-- V_e0, V_r0 sont des vecteurs e0, r0 qui est initialisé
	[V_e,V_r]=initialise_grille(n,e0,r0)
	//-- M_e0, M_r0 sont des matrices i,j ; i suit x, j suit y
	[M_e0,M_r0]=affiche_matrice(V_e,V_r,n)
	//-- simuler e(t) & r(t) pour chaque cellule
	for i=1:1:(n*n)
		main_modele_cell(t0,dt,T,V_e(i,1),V_r(i,1),i)
	end

endfunction

//-- L'exemple --//
//T=100		//T
//t0=0		//Temps initial
//dt=0.01 	//Pas de temps
//e0=1.0	//e initial
//r0=0.0	//r initial
//n=2		//nxn taille de grille

//main_initialise(T,t0,dt,e0,r0,n)
