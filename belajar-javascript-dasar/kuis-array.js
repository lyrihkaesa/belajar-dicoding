/**
 * TODO:
 * Buatlah sebuah variabel dengan nama evenNumber yang merupakan sebuah array dengan ketentuan:
 *   - Array tersebut menampung bilangan genap dari 1 hingga 100
 *
 * Catatan:
 *   - Agar lebih mudah, gunakanlah for loop dan logika if untuk mengisi bilangan genap pada array.
 */

// TODO
let evenNumber = [];
for (let index = 1; index <= 100; index++) {
  if (index % 2 === 0) {
    evenNumber.push(index);
  }
}

console.log("eventNumber :>> ", evenNumber);

/**
 * Jangan hapus kode di bawah ini
 */

module.exports = evenNumber;
