//Genère les vecteurs e0, r0 initiaux pour le cas physique
function[e0,r0]=genere_cond_initial(n)
if n>1 then
	dx = 1/(n-1) //le pas entre des x
	dy = dx  //le pas entre des y
	
	//remplir avec les valeurs imposées pour y=0 .. 1 
	e0 = zeros(n,1)
	ry=dy
	while ry<0.5
	    e0 = [e0 ; zeros(n,1)]
	    ry=ry+dy
	end
	ry_n=ry
	for ry=ry_n:dy:1
	    e0 = [e0 ; ones(n,1)]
	end

	//remplir avec les valeurs imposées pour x=0 .. 1 
	r0 = zeros(n/2 , 1)
	r0 = [r0 ; ones(ceil(n-n/2) , 1)]
	for rx=dx:dx:1
		r0 = [r0 ; zeros(n/2 , 1)]
		r0 = [r0 ; ones(ceil(n-n/2) , 1)]
	end
else
	e0=0
	r0=0
end
endfunction

//Appeler la fonction "fonct_corrige"
exec('exo10_correctif.sci',-1)


//-- L'exemple --//

//D=1  		//Constant conductivité
//n=2 		//Taille de grille
//T=2		//T
//t0=0 		//Temps initial
//dt=0.0001	//Pas de temps

//--les vecteurs (condition) initiaux de taille n*n : 
//[e0,r0]=genere_cond_initial(n)

//simule e(t) & r(t)
//main_correctif(t0,dt,T,e0,r0,D,n)
