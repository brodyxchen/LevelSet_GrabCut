function binMask = BFS(graph, inputR,inputC, inputR2, inputC2, diff)

diff = abs(diff);

[m n]=size(graph);
binMask=zeros(m,n);
flags=zeros(m,n);

r=inputR;
c=inputC;
gray=graph(r,c);






%%%%%%%%%%%%%%%
binMask(r,c)=1;
flags(r,c)=1;
queueR=r;
queueC=c;

moveR=[-1,0,+1,0];
moveC=[0,+1,0,-1];

while isempty(queueR)==false
    newR=queueR(1);queueR(1)=[];
    newC=queueC(1);queueC(1)=[];
    
    for i=1:1:4
        r=newR+moveR(i);
        c=newC+moveC(i);
        if(r>=1 && r <=m && c>=1 &&c <= n)
            if( flags(r,c) == 0)
                flags(r,c)=1;
                if( abs(graph(r,c)-gray)<diff)
                    queueR=[queueR;r];
                    queueC=[queueC;c];
                    binMask(r,c)=1;
                end
            end
        end
    end
 
end





%%%%%%%%%%%%
r=inputR2;
c=inputC2;
gray=graph(r,c);

binMask(r,c)=1;
flags(r,c)=1;
queueR=r;
queueC=c;

moveR=[-1,0,+1,0];
moveC=[0,+1,0,-1];

while isempty(queueR)==false
    newR=queueR(1);queueR(1)=[];
    newC=queueC(1);queueC(1)=[];
    
    for i=1:1:4
        r=newR+moveR(i);
        c=newC+moveC(i);
        if(r>=1 && r <=m && c>=1 &&c <= n)
            if( flags(r,c) == 0)
                flags(r,c)=1;
                if( abs(graph(r,c)-gray)<diff)
                    queueR=[queueR;r];
                    queueC=[queueC;c];
                    binMask(r,c)=1;
                end
            end
        end
    end
 
end





end



