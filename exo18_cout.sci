//appeler les scripts nécessaires pour pouvoir utiliser toutes les méthodes
exec('exo5_initialise_grille.sci',-1)
exec('exo9_modele_complet.sci',-1)
exec('exo10_correctif.sci',-1)
exec('exo12_splitting.sci',-1)
exec('exo16_splitting_problem.sci',-1)

//Cout exo5(initialisation de grille)
val=0
T=100		//T
t0=0		//Temps initial
dt=0.01 	//Pas de temps
e0=1.0		//e initial
r0=0.0		//r initial
for n=2:2:4

	timer()
	main_initialise(T,t0,dt,e0,r0,n)
	time1=timer()

	//--tableau de temps de calcul selon n (n = 0,2,4,6)
	val= [val, time1]

end

//Cout exo9(problème modèle complet)
val=0
D=1  		//Constant conductivité
T=50		//T
t0=0		//Temps initial
dt=0.01 	//Pas de temps

for n=2:2:4

	//--les vecteurs (condition) initiaux de taille n*n 
	e0=ones(n*n,1)
	r0=zeros(n*n,1)

	timer()
	main_modele_complet(t0,dt,T,e0,r0,D,n)
	time1=timer()

	//--tableau de temps de calcul selon n (n = 0,2,4,6)
	val= [val, time1]

end

//Cout exo10(problème modèle complet avec fonctions correctives)
val=0
D=1  		//Constant conductivité
T=50		//T
t0=0		//Temps initial
dt=0.01 	//Pas de temps

for n=2:2:4

	//--les vecteurs (condition) initiaux de taille n*n  : 
	//--Ici, c'est de la solution corrigé au t0 pour tester
	[x,y]=genere_xy(n)  
	[e0,r0]=grille_solution(x,y,t0)

	timer()
	main_correctif(t0,dt,T,e0,r0,D,n)
	time1=timer()

	//--tableau de temps de calcul selon n (n = 0,2,4,6)
	val= [val, time1]

end

//Cout exo12(problème modèle complet avec splitting façon 1)
val=0
D=1  		//Constant conductivité
T=50		//T
t0=0		//Temps initial
dt=0.01 	//Pas de temps

for n=2:2:4

	//--les vecteurs (condition) initiaux de taille n*n 
	e0=ones(n*n,1)
	r0=zeros(n*n,1)

	timer()
	main_splitting(t0,dt,T,e0,r0,D,n)
	time1=timer()

	//--tableau de temps de calcul selon n (n = 0,2,4,6)
	val= [val, time1]

end

//Cout exo16(problème modèle complet avec splitting façon 2 avec rk2,cn2)
val=0
D=1  		//Constant conductivité
T=50		//T
t0=0		//Temps initial
dt=0.01 	//Pas de temps

for n=2:2:4

	//--les vecteurs (condition) initiaux de taille n*n 
	e0=ones(n*n,1)
	r0=zeros(n*n,1)

	timer()
	main_splitting_problem(t0,dt,T,e0,r0,D,n)
	time1=timer()

	//--tableau de temps de calcul selon n (n = 0,2,4,6)
	val= [val, time1]

end
