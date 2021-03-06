clear all

syms X x y th u1 u2 u3 
f=[u1*cos(th), u1*sin(th) , 0, 0].';
g1=[0 0 1 0].';     g2=[0 0 0 1].';
h1=x;               h2=y;
h=[h1 h2].';
X=[x y th u1].';

Lg1Lfh1 = jacobian((jacobian(h1,X)*f),X)*g1;
Lg2Lfh1 = jacobian((jacobian(h1,X)*f),X)*g2;
Lg2Lfh2 = jacobian((jacobian(h2,X)*f),X)*g2;
Lg1Lfh2 = jacobian((jacobian(h2,X)*f),X)*g1;

A=[Lg1Lfh1 Lg2Lfh1; Lg1Lfh2 Lg2Lfh2];

L2fh1 = jacobian((jacobian(h1,X)*f),X)*f;
L2fh2 = jacobian((jacobian(h2,X)*f),X)*f;

Lfh=[L2fh1; L2fh2];

%%

f=[0 0 -100 -200 100 -200 -200 -400 0 -400 200 -400].'
ft=[ 0 -100 100 -200 0 200;
    0 -200 -200 -400 -400 -400]
o=[1 1 1 1 1 1].'
F=kron(f,o') - kron(o,ft)

L=[0 0 0 0 0 0;
-.5 1 -.5 0 0 0;
-.5 -.5 1 0 0 0;
0 -.5 0 1 -.5 0
0 -.5 -.5 0 1 0
0 0 -.5 0 -.5 1]
eig(L)


%%
AA=[0 1; 0 0]
BB=[0 1].'
KK=acker(AA,BB,[-7 -43])
eig(AA-BB*(KK*.5))
% k1 k2 = 300 50


k11=300;
k12=50;
k21=300;
k22=50;


%%
syms t
f=[  0;                  0;
     -100-50*sin(t);    -200-100*sin(t);
        100+50*sin(t);     -200-100*sin(t);
        -200-100*sin(t);    -400-200*sin(t);
        0;                  -400-200*sin(t);
        200+100*sin(t);     -400-200*sin(t)];

ft=[ 0,                  0;
     -100-50*sin(t),    -200-100*sin(t);
        100+50*sin(t),     -200-100*sin(t);
        -200-100*sin(t),    -400-200*sin(t);
        0,                  -400-200*sin(t);
        200+100*sin(t),     -400-200*sin(t)].';
    
o=[1 1 1 1 1 1].'
F=kron(f,o') - kron(o,ft)
    