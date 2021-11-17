function vektor=fnKorelacijskaFunkcija(x,y)
        N = length(x);
        vektor = zeros(1,N);
        for m=0:N-1
            vektor(m+1) = sum(x.*y);
            y=[y(2:end);y(1)]; 
        end
        vektor = vektor./N;
        
end
            
        