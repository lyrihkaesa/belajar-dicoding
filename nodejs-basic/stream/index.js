/**
 * TODO:
 * Buatlah program untuk membaca teks input.txt dan menuliskannya ulang pada berkas output.txt
 * menggunakan teknik readable stream dan writable stream.
 */
const fs = require("fs");
const path = require("path");

const inputPath = path.resolve(__dirname, "input.txt");
const readableStream = fs.createReadStream(inputPath, {
  highWaterMark: 15,
});
let data = "";
let chunk;

readableStream.on("readable", () => {
  try {
    while ((chunk = readableStream.read()) != null) {
      data += `${chunk}\n`;
    }
  } catch (error) {
    console.log(error);
    // catch the error when the chunk cannot be read.
  }
});

readableStream.on("end", () => {
  const outputPath = path.resolve(__dirname, "output.txt");
  const writableStream = fs.createWriteStream(outputPath);
  writableStream.write(data);
  writableStream.end();

  console.log("Done");
});
