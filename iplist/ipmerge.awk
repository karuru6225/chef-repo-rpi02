BEGIN {
  for(i = 0; i < 32; i++){
    TABLE0[i] = 0
    TABLE1[i] = 0
    TABLE2[i] = 0
    TABLE3[i] = 0
    if(i >= 24){
      TABLE0[i] = 2^(i-24)
    }else if(i >= 16){
      TABLE1[i] = 2^(i-16)
    }else if(i >= 8){
      TABLE2[i] = 2^(i-8)
    }else{
      TABLE3[i] = 2^i
    }
  }
  lcc="00"
  la0=0
  la1=0
  la2=0
  la3=0
  lmask=0
}
{
  cc = $1
  a0 = $2
  a1 = $3
  a2 = $4
  a3 = $5
  msk = $6
  if( a0 == (la0 + TABLE0[32-msk]) &&
      a1 == (la1 + TABLE1[32-msk]) &&
      a2 == (la2 + TABLE2[32-msk]) &&
      a3 == (la3 + TABLE3[32-msk]) &&
      msk == lmask &&
      cc == lcc) {
    lmask = msk - 1
  }else{
    if(la0 != 0 || la1 != 0 || la2 != 0 || la3 != 0){
      print lcc" "la0" "la1" "la2" "la3" "lmask
    }
    lcc = cc
    la0 = a0
    la1 = a1
    la2 = a2
    la3 = a3
    lmask = msk
  }
}
END{
  print lcc" "la0" "la1" "la2" "la3" "lmask
}
