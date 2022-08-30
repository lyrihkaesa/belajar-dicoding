// TODO: tampilkan teks pada notes.txt pada console.
const fs = require("fs");
const path = require("path");

const fileReadCallback = (error, data) => {
  if (error) {
    console.log("Gagal membaca berkas");
    return;
  }
  console.log(data);
};

const notesPath = path.resolve(__dirname, "notes.txt");

fs.readFile(notesPath, "UTF-8", fileReadCallback);

// readableStream
const articlePath = path.resolve(__dirname, "article.txt");
const readableStream = fs.createReadStream(articlePath, {
  highWaterMark: 10,
});

readableStream.on("readable", () => {
  try {
    process.stdout.write(`[${readableStream.read()}]`);
  } catch (error) {
    console.log(error);
    // catch the error when the chunk cannot be read.
  }
});

readableStream.on("end", () => {
  console.log("Done");
});
