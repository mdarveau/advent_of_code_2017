a = 1;
b = 109900;
c = 126900;
d = 0;
e = 0;
f = 0;
g = 0;
h = 0;

do {
  f = 1;
  d = 2;

  do {
    // e = 2;
    // do {
    //   if ( (d * e) == b ) {
    //     f = 0;
    //   }
    //   e++;
    // } while ( e != b );
    if( b != d && b % d == 0 ){
      f = 0;
    }

    // console.log("d=" + d + " f=" + f);
    d++;
  } while ( d != b );

  if ( f == 0 ) {
    console.log("Yes: " + b);
    h++;
  } else {
    console.log("No: " + b);
  }
  b += 17;
} while ( b <= c );

console.log("h = " + h);