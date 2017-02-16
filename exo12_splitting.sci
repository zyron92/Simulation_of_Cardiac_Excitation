//pour appeler toutes les fonctions nécessaires dans le script 10
exec('exo10_correctif.sci',-1)

//Modification du script précédent pour splitting
function main_splitting(t0,dt,T,e0,r0,D,n)

    L=slaplacien(D,n);	//L choisi

    t=t0    		//t initial 
    nt=(T/dt)-1 	//nombre d'intervalles de T
    k0=round(t0/dt) 	//k initial

    //initialisation du graphe pour les cellules
    e=e0
    r=r0
    sim_t = t0
    sim_cell_e = e0
    sim_cell_r = r0

    for k=k0:1:(nt+1)
	//Etape 1
	res_e_mid = e+dt.*F(e,r)
	res_r_mid = r+dt.*G(e,r)
	//Etape 2
	res_etoile = res_e_mid+dt.*(L*res_e_mid)	
	//Etape 3
	res_e = res_etoile+dt.*F(res_etoile,res_r_mid)
	res_r = res_r_mid+dt.*G(res_etoile,res_r_mid)

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
//T=50		//T
//t0=0 		//Temps initial
//dt=0.01 	//Pas de temps

//--les vecteurs (condition) initiaux de taille n*n ; ici n=2
//e0=[1,0,1,0]'
//r0=[1,0,1,0]'

//-- simuler e(t) & r(t) pour les cellules
//main_splitting(t0,dt,T,e0,r0,D,n)
