//pour appeler toutes les fonctions nécessaires dans le script 10,15
exec('exo11_simulation.sci',-1)
exec('exo15_cn2.sci',-1)

//Modification du script précédent pour splitting avec rk2, cn2 avec fonctions correctives
function main_splitting_problem(t0,dt,T,e0,r0,D,n)

    L=slaplacien(D,n);	//L choisi

    t=t0+dt    		//t initial 
    nt=(T/dt)-1 	//nombre d'intervalles de T
    k0=round(t0/dt) 	//k initial

    //initialisation de la grille avec la solution manufacturée pour t=t0
    [x,y]=genere_xy(n)
    [res_e,res_r]=grille_solution(x,y,t0) //si jamais nt=0

    //initialisation du graphe pour les cellules
    e=e0
    r=r0
    sim_t = t0
    sim_cell_e = e0
    sim_cell_r = r0

    for k=k0:1:(nt+1)

	//Calcul des termes correctifs
	[sol_e,sol_r]=grille_solution(x,y,t)
        c1 = (sol_e - e -dt.*((L*e)+F(e,r))) ./ dt
	c2 = (sol_r - r -dt.*G(e,r)) ./ dt

	//Etape 1 rk2
	res_e_mid = e+(dt/2).*(F(e,r) + F(e+(dt/2).*F(e,r) , r+(dt/2).*F(e,r)))
	res_r_mid = r+(dt/2).*(G(e,r) + G(e+(dt/2).*G(e,r) , r+(dt/2).*G(e,r)))
	//Etape 2 cn2
	res_etoile = cn2(res_e_mid,dt,D,n,L)	
	//Etape 3 rk2
	res_e = res_etoile+(dt/2).*(F(res_etoile,res_r_mid) + F(res_etoile+(dt/2).*F(res_etoile,res_r_mid) , res_r_mid+(dt/2).*F(res_etoile,res_r_mid)))
	res_r = res_r_mid+(dt/2).*(G(res_etoile,res_r_mid) + G(res_etoile+(dt/2).*G(res_etoile,res_r_mid) , res_r_mid+(dt/2).*G(res_etoile,res_r_mid)))

	//Ajoute les éléments correctifs
	res_e = res_e + c1
	res_r = res_r + c2
	e=res_e
	r=res_r

        t=(k+1)*dt

	//Accumulation des données les cellules
	sim_t = [ sim_t , t ]
	sim_cell_e = [ sim_cell_e , res_e ]
	sim_cell_r = [ sim_cell_r , res_r ]
    end

    //Graphe pour les cellules
    for i=1:1:(n*n)
	xset("window",i);  //i designe n°fenetre = ((indice y_j)-1)(n)+(indice x_i)
	plot2d(sim_t,sim_cell_e(i,:),style=5)  //tracé rouge
	plot2d(sim_t,sim_cell_r(i,:),style=4)  //tracé bleu
    end

endfunction


//-- L'exemple --//

//D=1  		//Constant conductivité
//n=2 		//Taille de grille
//T=2		//T
//t0=0 		//Temps initial
//dt=0.0001	//Pas de temps

//--les vecteurs (condition) initiaux de taille n*n et matrice L (la meme que dans l'exo11)
//[e0,r0]=genere_cond_initial(n)

//simule e(t) & r(t)
//main_splitting_problem(t0,dt,T,e0,r0,D,n)
