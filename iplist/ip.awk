BEGIN{
  FS="[|.]"
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
}
{
  n = $8
  a0 = $4
  a1 = $5
  a2 = $6
  a3 = $7
  while(n>0){
    for(i = 1; i < 32; i++){
      if( 2^(32 - i) <= n ){
        print $2" "a0" "a1" "a2" "a3" "i;
        n -= 2^(32 - i);
        a0 += TABLE0[32-i];
        a1 += TABLE1[32-i];
        a2 += TABLE2[32-i];
        a3 += TABLE3[32-i];
      }
    }
  }
}
