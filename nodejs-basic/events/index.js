// TODO 1
const { EventEmitter } = require("events");

const birthdayEventListener = (name) => {
  console.log(`Happy birthday ${name}!`);
};

// TODO 2
const myEvent = new EventEmitter();

// TODO 3
myEvent.on("birthday", birthdayEventListener);

// TODO 4
myEvent.emit("birthday", "Kaesa");
