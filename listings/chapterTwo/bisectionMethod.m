## bisectionMethod

function [ x,i,imax,ascisse ] = bisectionMethod (f,a,b,tolx)
ascisse = [];
fa = feval(f,a);
fb = feval(f,b);

x=(a+b)/2;
ascisse = [ascisse x];

fx = feval(f,x);
imax = ceil(log2(b-a)-log2(tolx));
for i = 2:imax
	f1x = ((fb-fa)/(b-a));
	if abs(fx)<=tolx*abs(f1x);
		break
	elseif fa*fx<0
		b=x;
		fb=fx;
	else
		a=x;
		fa=fx;
	end
	x=(a+b)/2;
	ascisse = [ascisse x];
	fx=feval(f,x);
end
i = i - 1;
endfunction
