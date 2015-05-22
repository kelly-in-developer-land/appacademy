function range(start, end) {
  if (end < start) {
    return [];
  } else if (start === end) {
    return [end];
  } else {
    return [start].concat(range(start + 1, end));
  }
}

// console.log(range(1,1500))


function sum(arr) {
  if(arr.length === 1) {
    return arr[0];
  } else {
    return arr[0] + sum(arr.slice(1, arr.length));
  }
}

// console.log(sum([1,2,3,4,5]));

function exponent(base, n) {
  if (n === 0) {
    return 1;
  } else {
    return base * exponent(base, n - 1);
  }
}

// console.log(exponent(100,0))

function exponent2(base, n) {
  if (n === 0) {
    return 1;
  } else if (n === 1) {
    return base;
  } else if (n % 2 === 0) {
    return exponent2(base, n /2) * exponent2(base, n /2);
  } else if (n % 2 === 1) {
    return base * (exponent2(base, (n - 1) / 2) * exponent2(base, (n - 1) / 2));
  }
}

// console.log(exponent2(3,3))

function nthFib(n) {
  if( n <= 1) {
    return 0
  } else if ( n === 2) {
    return 1
  } else {
    return nthFib(n - 1) + nthFib(n - 2)
  }
}

function fib(n){
  if (n === 1){
    return [0];
  } else if (n === 2) {
    return [0,1];
  } else {
    return fib(n-1).concat([nthFib(n)]);
  }
}

// function binarySearch(array, target) {
//   if (array.length === 0) {
//     return null
//   } else {
//     var splitterIndex = Math.floor(array.length/2)
//     var splitter = array[splitterIndex]
//     slice_smaller = array.slice(0, splitterIndex + 1)
//     slice_bigger = array.slice(splitterIndex + 1, array.length)
//     console.log(slice_smaller)
//     console.log(slice_bigger)
//     if(splitter === target) {
//       return splitterIndex
//     } else if (splitter > target){
//       return binarySearch(slice_smaller, 3);
//     } else {
//       if (binarySearch(slice_bigger, 3) === null) {
//         return null;
//       } else {
//         return slice_smaller.length + binarySearch(slice_bigger, 3);
//       }
//     }
//   }
// }
//
// console.log(binarySearch([0,1,2,3,4,5], 4))
