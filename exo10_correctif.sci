//Appeler la fonction F, G
exec('exo4_modele_cell.sci',-1)

//Appeler la fonction slaplacien
exec('exo7_slaplacien.sci',-1)

//la fonction Ua 
function[z]=Ua(x,y,t)
    z=cos(%pi.*x).*cos(%pi.*y).*exp(-t)
endfunction

//la fonction Va
function[z]=Va(x,y,t)
    z=cos(2.*%pi.*x).*cos(2.*%pi.*y).*exp(-t)
endfunction

//la fonction qui génère des vecteurs x, y de taille n*n avec des valeurs x et y associé à la grille de taille n*n
function[res_x,res_y]=genere_xy(n)
	dx = 1/(n-1) //le pas entre des x
	dy = dx  //le pas entre des y
	//les valeurs de x et y pour y=0   	
	res_x = [0 : dx : 1]'
	res_y = zeros(n,1)
	//remplir avec les valeurs de x et y pour y=dt .. 1  
	for ry=dy:dy:1
	    x = [0 : dx : 1]'
	    res_x=[res_x ; x ]
	    y = zeros(n,1)+ry
	    res_y=[res_y ; y ]
	end
endfunction

//la fonction pour remplir la grille avec la solution manufacturé à un t donné, x, y
function[sol_e,sol_r]=grille_solution(x,y,t)
        sol_e=Ua(x,y,t)	
	sol_r=Va(x,y,t)
endfunction

//Modification du script précédent pour appliquer la solution manufacturée
function main_correctif(t0,dt,T,e0,r0,D,n)

    L=slaplacien(D,n);	//L choisi

    t=t0    		//t initial 
    nt=(T/dt)-1 	//nombre d'intervalles de T
    k0=round(t0/dt) 	//k initial
    
    //initialisation de la grille avec la solution manufacturée pour t=t0
    [x,y]=genere_xy(n)
    [e,r]=grille_solution(x,y,t0)
    [res_e,res_r]=grille_solution(x,y,t0) //si jamais nt=0
	
    //initialisation de la grille avec e0, r0 passés en paramètre
    e_nouv=e0
    r_nouv=r0
    res_e_nouv=e0  //si jamais nt=0
    res_r_nouv=r0  //si jamais nt=0

    //initialisation du graphe pour les cellules
    sim_t = t0
    sim_cell_e = e_nouv
    sim_cell_r = r_nouv

    for k=k0:1:(nt+1)
	//les valeurs de la solution manufacturée
	[sol_e,sol_r]=grille_solution(x,y,t)
	//Calcul des termes correctifs
        c1 = (sol_e - e -dt.*((L*e)+F(e,r))) ./ dt
	c2 = (sol_r - r -dt.*G(e,r)) ./ dt
	//En appliquant les termes correctifs, on résout le problème itérativement pour continuer à trouver les termes correctifs
	res_e = e+dt.*((L*e)+F(e,r)+c1)
	res_r = r+dt.*(G(e,r)+c2)
	e=res_e
	r=res_r
	
	//Résolution d'un problème initialisé par e0, r0 en appliquant les fonctions correctifs
	res_e_nouv = e_nouv+dt.*((L*e_nouv)+F(e_nouv,r_nouv)+c1)
	res_r_nouv = r_nouv+dt.*(G(e_nouv,r_nouv)+c2)
	e_nouv=res_e_nouv
	r_nouv=res_r_nouv

        t=(k+1)*dt

	//Accumulation des données les cellules
	sim_t = [ sim_t , t ]
	sim_cell_e = [ sim_cell_e , res_e_nouv ]
	sim_cell_r = [ sim_cell_r , res_r_nouv ]
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
//n=2		//Taille de grille
//T=50		//T
//t0=0 		//Temps initial
//dt=0.01 	//Pas de temps

//--les vecteurs (condition) initiaux de taille n*n  : 
//--Ici, c'est de la solution corrigé au t0 pour tester
//[x,y]=genere_xy(n)  
//[e0,r0]=grille_solution(x,y,t0)

//-- simuler e(t) & r(t) pour les cellules
//main_correctif(t0,dt,T,e0,r0,D,n)
