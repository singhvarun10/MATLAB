%Data Code
clear
basemva = 100; accuracy = 0.001; maxiter = 10;
% 4-BUS TEST SYSTEM (American Electric Power)
% Bus Bus Voltage Angle ---Load---- -------Generator----- Injected
% No code Mag. Degree MW Mvar MW Mvar Qmin Qmax Mvar
busdata=[1 1 1.06 0.0 0.0 0.0 0.0 0.0 0 0 0
2 0 1.00 0.0 0.5 0.2 0.0 0.0 0 0 0
3 0 1.00 0.0 0.4 0.3 0.0 0.0 0 0 0
4 0 1.00 0.0 0.3 0.1 0.0 0.0 0 0 0];
% Line code
% Bus bus R X 1/2 B = 1 for lines
% nl nr p.u. p.u. p.u. > 1 or < 1 tr. tap at bus nl
linedata=[1 2 2.0000 -8.0000 0.00000 1
1 3 1.0000 -4.0000 0.00000 1
2 4 1.0000 -4.0000 0.00000 1
2 3 0.6660 -2.6640 0.00000 1
3 4 2.0000 -8.0000 0.00000 1];
Lfybus % form the bus admittance matrix
Lfgauss% Load flow solution by Newton-Raphson method
Busout % Prints the power flow solution on the screen
Lineflow % computes and displays the line flow and losses

%Lfybus
% This program obtains th Bus Admittance Matrix for power flow solution
j=sqrt(-1); i = sqrt(-1);
nl = linedata(:,1); nr = linedata(:,2); R = linedata(:,3);
X = linedata(:,4); Bc = j*linedata(:,5); a = linedata(:, 6);
nbr=length(linedata(:,1)); nbus = max(max(nl), max(nr));
Z = R + j*X; y= ones(nbr,1)./Z; %branch admittance
for n = 1:nbr
if a(n) <= 0 a(n) = 1; else end
Ybus=zeros(nbus,nbus); % initialize Ybus to zero
% formation of the off diagonal elements
for k=1:nbr;
Ybus(nl(k),nr(k))=Ybus(nl(k),nr(k))-y(k)/a(k);
Ybus(nr(k),nl(k))=Ybus(nl(k),nr(k));
end
end
% formation of the diagonal elements
for n=1:nbus
for k=1:nbr
if nl(k)==n
Ybus(n,n) = Ybus(n,n)+y(k)/(a(k)^2) + Bc(k);
elseif nr(k)==n
Ybus(n,n) = Ybus(n,n)+y(k) +Bc(k);
else, end
end
end
clear Pgg

%Lfgauss
% Power flow solution by Gauss-Seidel method
Vm=0; delta=0; yload=0; deltad =0;
nbus = length(busdata(:,1));
for k=1:nbus
n=busdata(k,1);
kb(n)=busdata(k,2); Vm(n)=busdata(k,3); delta(n)=busdata(k, 4);
Pd(n)=busdata(k,5); Qd(n)=busdata(k,6); Pg(n)=busdata(k,7); Qg(n) = busdata(k,8);
Qmin(n)=busdata(k, 9); Qmax(n)=busdata(k, 10);
Qsh(n)=busdata(k, 11);
if Vm(n) <= 0 Vm(n) = 1.0; V(n) = 1 + j*0;
else delta(n) = pi/180*delta(n);
V(n) = Vm(n)*(cos(delta(n)) + j*sin(delta(n)));
P(n)=(Pg(n)-Pd(n))/basemva;
Q(n)=(Qg(n)-Qd(n)+ Qsh(n))/basemva;
S(n) = P(n) + j*Q(n);
end
DV(n)=0;
end
num = 0; AcurBus = 0; converge = 1;
Vc = zeros(nbus,1)+j*zeros(nbus,1); Sc = zeros(nbus,1)+j*zeros(nbus,1);
while exist('accel')~=1
accel = 1.3;
end
while exist('accuracy')~=1
accuracy = 0.001;
end
while exist('basemva')~=1
basemva= 100;
end
while exist('maxiter')~=1
maxiter = 100;
end
iter=0;
maxerror=10;
while maxerror >= accuracy & iter <= maxiter
iter=iter+1;
for n = 1:nbus;
YV = 0+j*0;
for L = 1:nbr;
if nl(L) == n, k=nr(L);
YV = YV + Ybus(n,k)*V(k);
elseif nr(L) == n, k=nl(L);
YV = YV + Ybus(n,k)*V(k);
end
end
Sc = conj(V(n))*(Ybus(n,n)*V(n) + YV) ;
Sc = conj(Sc);
DP(n) = P(n) - real(Sc);
DQ(n) = Q(n) - imag(Sc);
if kb(n) == 1
S(n) =Sc; P(n) = real(Sc); Q(n) = imag(Sc); DP(n) =0; DQ(n)=0;
Vc(n) = V(n);
elseif kb(n) == 2
Q(n) = imag(Sc); S(n) = P(n) + j*Q(n);
if Qmax(n) ~= 0
Qgc = Q(n)*basemva + Qd(n) - Qsh(n);
if abs(DQ(n)) <= .005 & iter >= 10 % After 10 iterations
if DV(n) <= 0.045 % the Mvar of generator buses are
if Qgc < Qmin(n), % tested. If not within limits Vm(n)
Vm(n) = Vm(n) + 0.005; % is changed in steps of 0.005 pu
DV(n) = DV(n)+.005; % up to .05 pu in order to bring
elseif Qgc > Qmax(n), % the generator Mvar within the
Vm(n) = Vm(n) - 0.005; % specified limits.
DV(n)=DV(n)+.005; end
else, end
else,end
else,end
end
if kb(n) ~= 1
Vc(n) = (conj(S(n))/conj(V(n)) - YV )/ Ybus(n,n);
else, end
if kb(n) == 0
V(n) = V(n) + accel*(Vc(n)-V(n));
Varun Singh Inda
16BEE0023
elseif kb(n) == 2
VcI = imag(Vc(n));
VcR = sqrt(Vm(n)^2 - VcI^2);
Vc(n) = VcR + j*VcI;
V(n) = V(n) + accel*(Vc(n) -V(n));
end
end
maxerror=max( max(abs(real(DP))), max(abs(imag(DQ))) );
if iter == maxiter & maxerror > accuracy
fprintf('\nWARNING: Iterative solution did not converged after ')
fprintf('%g', iter), fprintf(' iterations.\n\n')
fprintf('Press Enter to terminate the iterations and print the results \n')
converge = 0; pause, else, end
end
if converge ~= 1
tech= (' ITERATIVE SOLUTION DID NOT CONVERGE'); else,
tech=(' Power Flow Solution by Gauss-Seidel Method');
end
k=0;
for n = 1:nbus
Vm(n) = abs(V(n)); deltad(n) = angle(V(n))*180/pi;
if kb(n) == 1
S(n)=P(n)+j*Q(n);
Pg(n) = P(n)*basemva + Pd(n);
Qg(n) = Q(n)*basemva + Qd(n) - Qsh(n);
k=k+1;
Pgg(k)=Pg(n);
elseif kb(n) ==2
k=k+1;
Pgg(k)=Pg(n);
S(n)=P(n)+j*Q(n);
Qg(n) = Q(n)*basemva + Qd(n) - Qsh(n);
end
yload(n) = (Pd(n)- j*Qd(n)+j*Qsh(n))/(basemva*Vm(n)^2);
end
Pgt = sum(Pg); Qgt = sum(Qg); Pdt = sum(Pd); Qdt = sum(Qd); Qsht = sum(Qsh);
busdata(:,3)=Vm'; busdata(:,4)=deltad';
clear AcurBus DP DQ DV L Sc Vc VcI VcR YV converge delta

%LineFlow
% This program is used in conjunction with lfgauss or lf Newton
% for the computation of line flow and line losses.
SLT = 0;
fprintf('\n')
fprintf(' Line Flow and Losses \n\n')
fprintf(' --Line-- Power at bus & line flow --Line loss-- Transformer\n')
fprintf(' from to MW Mvar MVA MW Mvar tap\n')
for n = 1:nbus
busprt = 0;
for L = 1:nbr;
if busprt == 0
fprintf(' \n'), fprintf('%6g', n), fprintf(' %9.3f', P(n)*basemva)
Varun Singh Inda
16BEE0023
fprintf('%9.3f', Q(n)*basemva), fprintf('%9.3f\n', abs(S(n)*basemva))
busprt = 1;
else, end
if nl(L)==n k = nr(L);
In = (V(n) - a(L)*V(k))*y(L)/a(L)^2 + Bc(L)/a(L)^2*V(n);
Ik = (V(k) - V(n)/a(L))*y(L) + Bc(L)*V(k);
Snk = V(n)*conj(In)*basemva;
Skn = V(k)*conj(Ik)*basemva;
SL = Snk + Skn;
SLT = SLT + SL;
elseif nr(L)==n k = nl(L);
In = (V(n) - V(k)/a(L))*y(L) + Bc(L)*V(n);
Ik = (V(k) - a(L)*V(n))*y(L)/a(L)^2 + Bc(L)/a(L)^2*V(k);
Snk = V(n)*conj(In)*basemva;
Skn = V(k)*conj(Ik)*basemva;
SL = Snk + Skn;
SLT = SLT + SL;
else, end
if nl(L)==n | nr(L)==n
fprintf('%12g', k),
fprintf('%9.3f', real(Snk)), fprintf('%9.3f', imag(Snk))
fprintf('%9.3f', abs(Snk)),
fprintf('%9.3f', real(SL)),
if nl(L) ==n & a(L) ~= 1
fprintf('%9.3f', imag(SL)), fprintf('%9.3f\n', a(L))
else, fprintf('%9.3f\n', imag(SL))
end
else, end
end
end
SLT = SLT/2;
fprintf(' \n'), fprintf(' Total loss ')
fprintf('%9.3f', real(SLT)), fprintf('%9.3f\n', imag(SLT))
clear Ik In SL SLT Skn Snk

%BusOut
% This program prints the power flow solution in a tabulated form
% on the screen.
%clc
disp(tech)
fprintf(' Maximum Power Mismatch = %g \n', maxerror)
fprintf(' No. of Iterations = %g \n\n', iter)
head =[' Bus Voltage Angle ------Load------ ---Generation--- Injected'
' No. Mag. Degree MW Mvar MW Mvar Mvar '
' '];
disp(head)
for n=1:nbus
fprintf(' %5g', n), fprintf(' %7.3f', Vm(n)),
fprintf(' %8.3f', deltad(n)), fprintf(' %9.3f', Pd(n)),
fprintf(' %9.3f', Qd(n)), fprintf(' %9.3f', Pg(n)),
fprintf(' %9.3f ', Qg(n)), fprintf(' %8.3f\n', Qsh(n))
end
Varun Singh Inda
16BEE0023
fprintf(' \n'), fprintf(' Total ')
fprintf(' %9.3f', Pdt), fprintf(' %9.3f', Qdt),
fprintf(' %9.3f', Pgt), fprintf(' %9.3f', Qgt), fprintf(' %9.3f\n\n', Qsht)

