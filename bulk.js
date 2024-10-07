const admin = require('firebase-admin');
const serviceAccount = require('./path-to-your-service-account-key.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const groceries = [
  {
    name: "Apple",
    category: "Fruits",
    price: 100,
    imageUrl: "https://example.com/apple.jpg",
    availability: true,
    description: "Fresh red apples"
  },
  {
    name: "Milk",
    category: "Dairy",
    price: 50,
    imageUrl: "https://example.com/milk.jpg",
    availability: true,
    description: "Organic full cream milk"
  },
  // Add more grocery items here...
];

groceries.forEach(async (grocery) => {
  await db.collection('groceries').add(grocery);
  console.log(`${grocery.name} added to Firestore.`);
});
