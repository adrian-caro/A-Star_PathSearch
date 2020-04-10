function [mapa,solucion]=a_star(mapa)

tic
%Nodo inicial=3;
%Nodo final=9;
%Pared=1;
%Libre=0;

%1 2 3 4 5 6 7 8 9 0 1 2 3 4 5
% mapa = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
%     1 0 0 0 0 0 0 0 1 0 0 0 0 0 1;
%     1 0 1 1 1 1 1 0 1 0 1 1 1 0 1;
%     1 0 1 0 0 0 0 0 1 0 1 0 1 0 1;
%     3 0 1 0 1 1 1 1 1 0 1 0 1 0 1;
%     1 0 1 0 0 0 0 0 0 0 0 0 1 0 1;
%     1 0 1 0 1 1 1 1 1 1 1 0 1 0 1;
%     1 0 1 0 0 0 0 0 1 0 0 0 1 0 1;
%     1 0 1 0 1 0 1 0 1 1 1 1 1 0 1;
%     1 0 1 0 1 0 1 0 1 0 0 0 0 0 1;
%     1 0 1 0 1 0 1 0 1 0 1 1 1 1 1;
%     1 0 0 0 1 0 1 0 1 9 0 0 0 0 1;
%     1 1 1 1 1 0 1 1 1 1 1 1 1 0 1;
%     1 0 0 0 0 0 0 0 0 0 0 0 0 0 1;
%     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];



%%Comprobaciones
if size(mapa,1)~=size(mapa,2)
    error("Matrix is not square shaped");
end
if ismember(3,mapa)==0
    error("No initial point has been found.(Represented as '3'.");
end
if ismember(9,mapa)==0
    error("No final point has been found.(Represented as '9'.");
end
    
%para encontrar el nodo inicial y el final en la matriz.


%Nodo inicial
[i,j]= find(mapa==3);
filao=i;
columnao=j;

%Nodo goal
[i,j]= find(mapa==9);
filag=i;
columnag=j;
clear i j;
%% Se inicializa las listas
solucionado=0;
%lista de vivos, con el nodo inicial
vivos=struct;
vivos.x(1)=filao; %fila de la matriz
vivos.y(1)=columnao; %columna de la matriz
vivos.c(1)=0;%coste
vivos.h(1)=0;%heuristica
vivos.f(1)=0;%funcion=h+c
vivos.p=0; %padre

%lista de muertos
muertos=struct;
muertos.x=[];
muertos.y=[];
muertos.c=[];
muertos.h=[];
muertos.f=[];
muertos.p=[];


primermuerto=0;

%% Algoritmo

while isempty(vivos.x)~= 1
    primermuerto=primermuerto+1;
    
    
    
    %%busco el vivo con el valor de funcion mas peque�o
    q=find(vivos.f==min(vivos.f));
    q=q(1); %en el caso de haber varios iguales, se coge el primero
    
    
    
    
    
    
    
    %Si se encuentra una soluci�n:
    if (vivos.x(q)==filag && vivos.y(q)==columnag)
        disp('Solution found.');
        nummuertos=length(muertos.x)+1;
        muertos.x(nummuertos)=vivos.x(q);
        muertos.y(nummuertos)=vivos.y(q);
        muertos.c(nummuertos)=vivos.c(q);
        muertos.h(nummuertos)=vivos.h(q);
        muertos.f(nummuertos)=vivos.f(q);
        muertos.p(nummuertos)=vivos.p(q);
        solucionado=1;
        break
        
    end
    
    
    
    
    
    
    
    %el nodo padre a la lista de muertos
    if primermuerto==1 %si es el primero, tiene padre 0
        nummuertos=length(muertos.x)+1;
        muertos.x(nummuertos)=vivos.x(q);
        muertos.y(nummuertos)=vivos.y(q);
        muertos.c(nummuertos)=0;
        muertos.h(nummuertos)=0;
        muertos.f(nummuertos)=0;
        muertos.p(nummuertos)=0;
        
    else %para todos los dem�s
        nummuertos=length(muertos.x)+1;
        muertos.x(nummuertos)=vivos.x(q);
        muertos.y(nummuertos)=vivos.y(q);
        muertos.c(nummuertos)=vivos.c(q);
        muertos.h(nummuertos)=vivos.h(q);
        muertos.f(nummuertos)=vivos.f(q);
        muertos.p(nummuertos)=vivos.p(q);
        
    end
    
    indicepadrerecienmuerto=length(muertos.x);
    
    
    
    
    
    
    
    
    
    %Se generan los posibles hijos del seleccionado.
    %     N -->  North       (i-1, j)
    %     S -->  South       (i+1, j)
    %     E -->  East        (i, j+1)
    %     W -->  West        (i, j-1)
    
    %norte
    
    if vivos.x(q)-1>0 && mapa(vivos.x(q)-1,vivos.y(q))~=1 %se comprueba que el hijo no sea una pared
        
        %busca si este sucesor est� en la lista de muertos ya.
        estaenmuertos=0;
        for i=1:length(muertos.x)
            if muertos.x(i)==vivos.x(q)-1 && muertos.y(i)==vivos.y(q)
                estaenmuertos=1;
                break
            end
        end
        
        
        if estaenmuertos==0 %%se comprueba que no est� en muertos.
            estaenvivos=0;
            for j=1:length(vivos.x) %%%%Se comprueba si est� en vivos
                if vivos.x(j)==vivos.x(q)-1 && vivos.y(j)==vivos.y(q)
                    estaenvivos=1;
                    if vivos.c(j)>vivos.c(q)+1%Si est� en vivos, se actualiza su coste
                        vivos.c(j)=vivos.c(q)+1;
                    end
                    break
                end
                
            end
            if estaenvivos==0 %Si no est� en vivos, se mete en vivos
                numvivos=length(vivos.x)+1;
                vivos.x(numvivos)=vivos.x(q)-1;
                vivos.y(numvivos)=vivos.y(q);
                vivos.c(numvivos)=vivos.c(q)+1;
                vivos.h(numvivos)=heuristica(vivos.x(numvivos),vivos.y(numvivos),filag,columnag);
                vivos.f(numvivos)=vivos.h(numvivos)+vivos.c(numvivos);
                vivos.p(numvivos)=indicepadrerecienmuerto;
            end
        end
        
    end
    
    
    
    
    
    %sur
    if vivos.x(q)+1<=size(mapa,1) && mapa(vivos.x(q)+1,vivos.y(q))~=1 %se comprueba que el hijo no sea una pared
        
        %busca si este sucesor est� en la lista de muertos ya.
        estaenmuertos=0;
        for i=1:length(muertos.x)
            if muertos.x(i)==vivos.x(q)+1 && muertos.y(i)==vivos.y(q)
                estaenmuertos=1;
                break
            end
        end
        
        
        if estaenmuertos==0 %%se comprueba que no est� en muertos.
            estaenvivos=0;
            for j=1:length(vivos.x) %%%%Se comprueba si est� en vivos
                if vivos.x(j)==vivos.x(q)+1 && vivos.y(j)==vivos.y(q)
                    estaenvivos=1;
                    if vivos.c(j)>vivos.c(q)+1%Si est� en vivos, se actualiza su coste
                        vivos.c(j)=vivos.c(q)+1;
                    end
                    break
                end
                
            end
            if estaenvivos==0 %Si no est� en vivos, se mete en vivos
                numvivos=length(vivos.x)+1;
                vivos.x(numvivos)=vivos.x(q)+1;
                vivos.y(numvivos)=vivos.y(q);
                vivos.c(numvivos)=vivos.c(q)+1;
                vivos.h(numvivos)=heuristica(vivos.x(numvivos),vivos.y(numvivos),filag,columnag);
                vivos.f(numvivos)=vivos.h(numvivos)+vivos.c(numvivos);
                vivos.p(numvivos)=indicepadrerecienmuerto;
            end
        end
        
    end
    
    
    %este
    if vivos.y(q)+1<=size(mapa,2) && mapa(vivos.x(q),vivos.y(q)+1)~=1%se comprueba que el hijo no sea una pared
        
        %busca si este sucesor est� en la lista de muertos ya.
        estaenmuertos=0;
        for i=1:length(muertos.x)
            if muertos.x(i)==vivos.x(q) && muertos.y(i)==vivos.y(q)+1
                estaenmuertos=1;
                break
            end
        end
        
        
        if estaenmuertos==0 %%se comprueba que no est� en muertos.
            estaenvivos=0;
            for j=1:length(vivos.x) %%%%Se comprueba si est� en vivos
                if vivos.x(j)==vivos.x(q) && vivos.y(j)==vivos.y(q)+1
                    estaenvivos=1;
                    if vivos.c(j)>vivos.c(q)+1%Si est� en vivos, se actualiza su coste
                        vivos.c(j)=vivos.c(q)+1;
                    end
                    break
                end
                
            end
            if estaenvivos==0 %Si no est� en vivos, se mete en vivos
                numvivos=length(vivos.x)+1;
                vivos.x(numvivos)=vivos.x(q);
                vivos.y(numvivos)=vivos.y(q)+1;
                vivos.c(numvivos)=vivos.c(q)+1;
                vivos.h(numvivos)=heuristica(vivos.x(numvivos),vivos.y(numvivos),filag,columnag);
                vivos.f(numvivos)=vivos.h(numvivos)+vivos.c(numvivos);
                vivos.p(numvivos)=indicepadrerecienmuerto;
            end
        end
        
    end
    
    %oeste
    if vivos.y(q)-1>0 && mapa(vivos.x(q),vivos.y(q)-1)~=1%se comprueba que el hijo no sea una pared
        
        %busca si este sucesor est� en la lista de muertos ya.
        estaenmuertos=0;
        for i=1:length(muertos.x)
            if muertos.x(i)==vivos.x(q) && muertos.y(i)==vivos.y(q)-1
                estaenmuertos=1;
                break
            end
        end
        
        
        if estaenmuertos==0 %%se comprueba que no est� en muertos.
            estaenvivos=0;
            for j=1:length(vivos.x) %%%%Se comprueba si est� en vivos
                if vivos.x(j)==vivos.x(q) && vivos.y(j)==vivos.y(q)-1
                    estaenvivos=1;
                    if vivos.c(j)>vivos.c(q)+1%Si est� en vivos, se actualiza su coste
                        vivos.c(j)=vivos.c(q)+1;
                    end
                    break
                end
                
            end
            if estaenvivos==0 %Si no est� en vivos, se mete en vivos
                numvivos=length(vivos.x)+1;
                vivos.x(numvivos)=vivos.x(q);
                vivos.y(numvivos)=vivos.y(q)-1;
                vivos.c(numvivos)=vivos.c(q)+1;
                vivos.h(numvivos)=heuristica(vivos.x(numvivos),vivos.y(numvivos),filag,columnag);
                vivos.f(numvivos)=vivos.h(numvivos)+vivos.c(numvivos);
                vivos.p(numvivos)=indicepadrerecienmuerto;
            end
        end
        
    end
    
%     
%     %diagonal inferior derecha + +
%     
%     if vivos.x(q)+1<=size(mapa,1) && vivos.y(q)+1<=size(mapa,2) && mapa(vivos.x(q)+1,vivos.y(q)+1)~=1 %se comprueba que el hijo no sea una pared
%         
%         %busca si este sucesor est� en la lista de muertos ya.
%         estaenmuertos=0;
%         for i=1:length(muertos.x)
%             if muertos.x(i)==vivos.x(q)+1 && muertos.y(i)==vivos.y(q)+1
%                 estaenmuertos=1;
%                 break
%             end
%         end
%         
%         
%         if estaenmuertos==0 %%se comprueba que no est� en muertos.
%             estaenvivos=0;
%             for j=1:length(vivos.x) %%%%Se comprueba si est� en vivos
%                 if vivos.x(j)==vivos.x(q)+1 && vivos.y(j)==vivos.y(q)+1
%                     estaenvivos=1;
%                     if vivos.c(j)>vivos.c(q)+2%Si est� en vivos, se actualiza su coste
%                         vivos.c(j)=vivos.c(q)+2;
%                     end
%                     break
%                 end
%                 
%             end
%             if estaenvivos==0 %Si no est� en vivos, se mete en vivos
%                 numvivos=length(vivos.x)+1;
%                 vivos.x(numvivos)=vivos.x(q)+1;
%                 vivos.y(numvivos)=vivos.y(q)+1;
%                 vivos.c(numvivos)=vivos.c(q)+2;
%                 vivos.h(numvivos)=heuristica(vivos.x(numvivos),vivos.y(numvivos),filag,columnag);
%                 vivos.f(numvivos)=vivos.h(numvivos)+vivos.c(numvivos);
%                 vivos.p(numvivos)=indicepadrerecienmuerto;
%             end
%         end
%         
%     end
%     %diagonal inferior izquierda + -
%     if vivos.x(q)+1<=size(mapa,1) && vivos.y(q)-1>0 && mapa(vivos.x(q)+1,vivos.y(q)-1)~=1 %se comprueba que el hijo no sea una pared
%         
%         %busca si este sucesor est� en la lista de muertos ya.
%         estaenmuertos=0;
%         for i=1:length(muertos.x)
%             if muertos.x(i)==vivos.x(q)+1 && muertos.y(i)==vivos.y(q)-1
%                 estaenmuertos=1;
%                 break
%             end
%         end
%         
%         
%         if estaenmuertos==0 %%se comprueba que no est� en muertos.
%             estaenvivos=0;
%             for j=1:length(vivos.x) %%%%Se comprueba si est� en vivos
%                 if vivos.x(j)==vivos.x(q)+1 && vivos.y(j)==vivos.y(q)-1
%                     estaenvivos=1;
%                     if vivos.c(j)>vivos.c(q)+2%Si est� en vivos, se actualiza su coste
%                         vivos.c(j)=vivos.c(q)+2;
%                     end
%                     break
%                 end
%                 
%             end
%             if estaenvivos==0 %Si no est� en vivos, se mete en vivos
%                 numvivos=length(vivos.x)+1;
%                 vivos.x(numvivos)=vivos.x(q)+1;
%                 vivos.y(numvivos)=vivos.y(q)-1;
%                 vivos.c(numvivos)=vivos.c(q)+2;
%                 vivos.h(numvivos)=heuristica(vivos.x(numvivos),vivos.y(numvivos),filag,columnag);
%                 vivos.f(numvivos)=vivos.h(numvivos)+vivos.c(numvivos);
%                 vivos.p(numvivos)=indicepadrerecienmuerto;
%             end
%         end
%         
%     end
%     
%     %diagonal superior derecha - +
%     
%     if vivos.y(q)+1<=size(mapa,2) && vivos.x(q)-1>0 && mapa(vivos.x(q)-1,vivos.y(q)+1)~=1 %se comprueba que el hijo no sea una pared
%         
%         %busca si este sucesor est� en la lista de muertos ya.
%         estaenmuertos=0;
%         for i=1:length(muertos.x)
%             if muertos.x(i)==vivos.x(q)-1 && muertos.y(i)==vivos.y(q)+1
%                 estaenmuertos=1;
%                 break
%             end
%         end
%         
%         
%         if estaenmuertos==0 %%se comprueba que no est� en muertos.
%             estaenvivos=0;
%             for j=1:length(vivos.x) %%%%Se comprueba si est� en vivos
%                 if vivos.x(j)==vivos.x(q)-1 && vivos.y(j)==vivos.y(q)+1
%                     estaenvivos=1;
%                     if vivos.c(j)>vivos.c(q)+2%Si est� en vivos, se actualiza su coste
%                         vivos.c(j)=vivos.c(q)+2;
%                     end
%                     break
%                 end
%                 
%             end
%             if estaenvivos==0 %Si no est� en vivos, se mete en vivos
%                 numvivos=length(vivos.x)+1;
%                 vivos.x(numvivos)=vivos.x(q)-1;
%                 vivos.y(numvivos)=vivos.y(q)+1;
%                 vivos.c(numvivos)=vivos.c(q)+2;
%                 vivos.h(numvivos)=heuristica(vivos.x(numvivos),vivos.y(numvivos),filag,columnag);
%                 vivos.f(numvivos)=vivos.h(numvivos)+vivos.c(numvivos);
%                 vivos.p(numvivos)=indicepadrerecienmuerto;
%             end
%         end
%         
%     end
%     
%     %diagonal superior izquierda - -
%     
%     if vivos.x(q)-1>0 && vivos.y(q)-1>0 && mapa(vivos.x(q)-1,vivos.y(q)-1)~=1 %se comprueba que el hijo no sea una pared
%         
%         %busca si este sucesor est� en la lista de muertos ya.
%         estaenmuertos=0;
%         for i=1:length(muertos.x)
%             if muertos.x(i)==vivos.x(q)-1 && muertos.y(i)==vivos.y(q)-1
%                 estaenmuertos=1;
%                 break
%             end
%         end
%         
%         
%         if estaenmuertos==0 %%se comprueba que no est� en muertos.
%             estaenvivos=0;
%             for j=1:length(vivos.x) %%%%Se comprueba si est� en vivos
%                 if vivos.x(j)==vivos.x(q)-1 && vivos.y(j)==vivos.y(q)-1
%                     estaenvivos=1;
%                     if vivos.c(j)>vivos.c(q)+2%Si est� en vivos, se actualiza su coste
%                         vivos.c(j)=vivos.c(q)+2;
%                     end
%                     break
%                 end
%                 
%             end
%             if estaenvivos==0 %Si no est� en vivos, se mete en vivos
%                 numvivos=length(vivos.x)+1;
%                 vivos.x(numvivos)=vivos.x(q)-1;
%                 vivos.y(numvivos)=vivos.y(q)-1;
%                 vivos.c(numvivos)=vivos.c(q)+2;
%                 vivos.h(numvivos)=heuristica(vivos.x(numvivos),vivos.y(numvivos),filag,columnag);
%                 vivos.f(numvivos)=vivos.h(numvivos)+vivos.c(numvivos);
%                 vivos.p(numvivos)=indicepadrerecienmuerto;
%             end
%         end
%         
%     end
    
    %elimino el padre de la lista de vivos
    vivos.x(q)=[];
    vivos.y(q)=[];
    vivos.c(q)=[];
    vivos.h(q)=[];
    vivos.f(q)=[];
    vivos.p(q)=[];
    
    
    %         Generating all the 8 successor of this cell
    %
    %             N.W   N   N.E
    %               \   |   /
    %                \  |  /
    %             W----Cell----E
    %                  / | \
    %                /   |  \
    %             S.W    S   S.E
    %
    %         Cell-->Popped Cell (i, j)
    %         N -->  North       (i-1, j)
    %         S -->  South       (i+1, j)
    %         E -->  East        (i, j+1)
    %         W -->  West           (i, j-1)
    %         N.E--> North-East  (i-1, j+1)
    %         N.W--> North-West  (i-1, j-1)
    %         S.E--> South-East  (i+1, j+1)
    %         S.W--> South-West  (i+1, j-1)
    
end
if solucionado==0
    error("Couldnt find any solution");
end

solucion=backtracking(muertos,filao,columnao);
for i=2:size(solucion,2)-1
    mapa(solucion(1,i),solucion(2,i))=5;
end
% mapa
toc
imagesc(mapa)
map = [1 1 1
    0 0 0
    0 0 0
    1 0 0
    1 0 0
    1 1 0
    1 1 0
    1 1 0
    1 1 0
    0 1 0];
colormap(map)
caxis([0 9])
set(gca,'visible','off')
daspect([1 1 1])
end