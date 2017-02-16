//la fonction F
function[y]=F(e,r)
    k=8
    a1=0.1
    y=-k.*e.*(e-a1).*(e-1)-e.*r
endfunction

//la fonction G
function[y]=G(e,r)
    k=8
    eps=0.01
    u1=0.1
    u2=0.1
    a2=0.1
    y=(eps+(u1.*(r ./ (e+u2)))).*(-r-(k.*e.*(e-a2-1)))
endfunction

//la fonction pour résoudre le problem
function main_modele_cell(t0,dt,T,e0,r0,num_fen)

    e=e0 		//e initial
    r=r0 		//r initial
    t=t0 		//t initial
    nt=(T/dt)-1 	//nombre d'intervalles de T
    k0=round(t0/dt) 	//k initial

    //Initialisation du graphe pour la cellule (x,y) choisie
    sim_t = t0
    sim_cell_e = e0
    sim_cell_r = r0

    for k=k0:1:(nt+1)
        res_e=e+dt.*F(e,r)
	res_r=r+dt.*G(e,r)
	e=res_e
	r=res_r
	t=(k+1)*dt

	//Accumulation des données la cellule
	sim_t = [ sim_t , t ]
	sim_cell_e = [ sim_cell_e , e ]
	sim_cell_r = [ sim_cell_r , r ]
    end

//Graphe pour la cellule
xset("window",num_fen); 
plot2d(sim_t,sim_cell_e,style=5)  //tracé rouge
plot2d(sim_t,sim_cell_r,style=4)  //tracé bleu

endfunction


//-- L'exemple --//
//T=100		//T
//t0=0		//Temps initial
//dt=0.1	//Pas de temps
//e0=1.0	//e initial
//r0=0.0	//r initial
//num_fen=1	//numéro de fenetre

//-- simuler e(t) & r(t)
//main_modele_cell(t0,dt,T,e0,r0,num_fen)
