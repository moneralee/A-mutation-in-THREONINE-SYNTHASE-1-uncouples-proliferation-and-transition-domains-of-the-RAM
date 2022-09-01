#######################################Functions-run before Threonine-model.R###########################################################################
library(deSolve)

#Thr network
Opnetwork1<-function(t, state, parameters) { 
  with(as.list(c(state, parameters)),{
    #node inputs
    dTHR <- TS1*(sustrate/(sustrate+KmTS1))+TS2*(sustrate/(sustrate+KmTS2))-decay*THR
    list(c(dTHR))
  })
}

#Import initial condition
initialcondition<-function(filename,x,y,coord1,coord2){
  a<-read.csv(file=filename,header=F)
  id<-dim(a)
  id<-id[1]
  coordenadas=matrix(nrow=coord1,ncol=coord2,0)        
  for(i in 1:coord1){
    if(i<=id){
      for(j in 1:coord2){coordenadas[i,j]<-a[i,j]}
    }
    else{coordenadas[i,]<-replicate(coord2, 0)}
  }
  return(coordenadas)
}

importid<-function(filename){
  a<-read.csv(file=filename,header=F)
  id<-dim(a)
  id<-id[1]
  return(id)
}

#module
mod<-function(x,m){
  t1<-floor(x/m)
  return(x-t1*m)}

#Find neighbors below a cell
findneighborsbelow<-function(i,id,coordenadas){
  ayuto<-0
  pop<-0
  for(j in 1:id){
    if(coordenadas[i,4]==coordenadas[j,4]){                       #same layer
      if(coordenadas[i,2]>coordenadas[j,2]){                     #count only cells below
        pop<-pop+1
        ayuto[pop]<-coordenadas[j,1]}}                              #save id's
  }
  return(ayuto)
}

#Plot field
plotField<-function(coordenadas,t,coordColors,field,x,y,simul){
  saver<-0
  domain=matrix(nrow=x,ncol=y)
  for(i in 1:y){    #ypos
    for(k in 1:x){   #xpos
      saver<-0
      for(j in 1:id){
        if((i>=coordenadas[j,2]) & (i<=coordenadas[j,3])){
          if((k>=coordenadas[j,4]) & (k<=coordenadas[j,5])){
            saver<-coordColors[j] 
          }}}
      domain[k,i]<-saver}}
  #the following marks the SCN, PD-TD boundary in the RAM, RAM-EZ boundary, EZ-DZ boundary (superimposed)
  domain[5:10,24]<-"cornflowerblue"
  domain[5:10,108]<-"cornflowerblue"
  domain[5:10,160]<-"cornflowerblue"
  domain[5:10,355]<-"cornflowerblue"
  
  png(filename=paste("output/",simul,"/Plot",field,"-",t,".png",sep=""), width = 1800, height = 300)
  plot.new()
  par(mar=rep(0, 4))
  plot.window(xlim=c(0, ncol(domain)), ylim=c(0, nrow(domain)), asp=1)
  o <- cbind(c(row(domain)), c(col(domain))) - 1
  rect(o[, 2], o[, 1], o[, 2] + 1, o[, 1] + 1, col=(domain)[, ncol(domain):1],border = NA ,density = 100,angle = c(30, -30))
  dev.off()
  return()}

sortcoord<-function(coordenadas,id){ 
  newid<-0
  coordenadashelper<-coordenadas
  order<-order(coordenadashelper[1:id,2])
  for (i in 1:id){
    if(coordenadashelper[order[i],1]!=0){
      newid<-newid+1
      coordenadas[newid,]<-coordenadashelper[order[i],]
      coordenadas[newid,1]<-newid}
  }
  return(coordenadas)}

#########colour palettes
library(viridis)
threonine<-mako(2000)
ts1<-mako(200)
ts2<-mako(200)
colores=matrix(nrow=17,ncol=12,0)  
colores[,1]<-c("#1e5262","#235e71","#276b80","#2c778f","#30839f","#3590ae","#399cbd","#44a6c6","#53adcb","#62b4cf","#71bbd4","#80c3d8","#8fcadd","#9ed1e1","#add8e6","#bcdfeb","#194553")# light blue To label epidermis
colores[,2]<-c("#454500","#595900", "#6c6c00", "#808000", "#949400", "#a7a700", "#bbbb00","#cece00","#e2e200","#f6f600","#ffff0a","#454500","#6c6c00","#949400","#bbbb00","#e2e200","#ffff0a")# yellow-olive To label cortex
colores[,3]<-c("#002700","#003b00", "#004e00", "#006200", "#007600", "#008900", "#009d00","#00b100","#00c400","#00d800","#00eb00","#004e00","#006200","#007600","#009d00","#00b100","#27ff27")#greens To label endodermis
colores[,4]<-c("#3b2000","#4e2b00", "#623600", "#764100", "#894b00", "#9d5600", "#b16100","#c46c00","#d87600","#eb8100","#ff8c00","#ff9514","#ff9e27","#ffa73b","#ffaf4e","#ffb862","#ffc176")#oranges To label pro-vasculars
colores[,5]<-c("#432843","#502f50", "#5c365c", "#683e68" ,"#754575" ,"#814c81", "#8d548d","#9a5b9a","#a464a4","#ab71ab","#b27db2","#b989b9","#c196c1","#c8a2c8","#cfaecf","#d7bbd7","#dec7de")#purples To label columella/Ep
colores[,6]<-c("#1e1e1e","#323232","#454545","#595959","#6c6c6c","#1e1e1e","#323232","#454545","#595959","#6c6c6c","#1e1e1e","#323232","#454545","#595959","#6c6c6c","#1e1e1e","#323232")# dark grays To label QC
colores[,7]<-c("#9acd2c","#9acd2c", "#9acd2c", "#9acd2c" ,"#9acd2c" ,"#9acd2c", "#9acd2c","#9acd2c", "#9acd2c","#9acd2c", "#9acd2c","#9acd2c", "#9acd2c","#9acd2c", "#9acd2c","#9acd2c", "#9acd2c")##To label CEI
colores[,8]<-c("#1e5262","#235e71","#276b80","#2c778f","#30839f","#3590ae","#399cbd","#44a6c6","#53adcb","#62b4cf","#71bbd4","#80c3d8","#8fcadd","#9ed1e1","#add8e6","#bcdfeb","#194553")# light blue To label epidermis in QC position, not proliferative
colores[,9]<-c("#cad5df","#beccd7", "#b2c2d0", "#a6b8c9", "#9aafc1", "#8da5ba", "#819bb2","#7592ab","#6988a3","#cad5df","#b2c2d0","#a6b8c9","#9aafc1","#8da5ba","#beccd7","#b2c2d0","#6988a3")  #greys for non dividing cells
colores[,11]<-c("#000032","#000045", "#000059", "#00006c", "#000080", "#000094", "#0000a7","#0000bb","#0000ce","#0000e2","#0000f6","#0a0aff","#1e1eff","#3232ff","#4545ff","#0000a7","#0000f6")#dividing cells
colores[,10]<-c("#1e5262","#235e71","#276b80","#2c778f","#30839f","#3590ae","#399cbd","#44a6c6","#53adcb","#62b4cf","#71bbd4","#80c3d8","#8fcadd","#9ed1e1","#add8e6","#bcdfeb","#194553")#epidermis SCN
colores[,12]<-c("#001300","#002700","#003b00","#004e00","#006200","#007500","#008900","#001300","#002700","#003b00","#004e00","#006200","#007500","#008900","#001300","#002700","#003b00") #elongating cells