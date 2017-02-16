//charger les scripts des fonctions laplacien et slaplacien
exec('exo6_laplacien.sci',-1)
exec('exo7_slaplacien.sci',-1)

//la fonction principal qui calcul la difference du temps entre  L*b et Ls*b
//l'hypothese est que cette différence >= 0
function[val]=calcul_temps(D,n)
//Calcul du temps d'exécution pour différents n de 5 jusqu'à n avec un pas de 5
val=0
for i=5:5:n

	//Initialisation de vecteur b
	b=ones(i*i,1)

	timer()
	L=laplacien(D,i)
	L*b
	time1=timer()

	timer()
	Ls=slaplacien(D,i)
	Ls*b
	time2=timer()

	//tableau de temps de calcul selon n (n = 0, 5 , 10 , ... , 40)
	val= [val, time1-time2]

end
endfunction

//-- L'Exemple --//
//n=40
//D=1
//val=calcul_temps(D,n)
