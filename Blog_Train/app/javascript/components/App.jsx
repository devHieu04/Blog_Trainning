import React, { useState } from 'react';


const App = () => {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Name:', name);
    console.log('Email:', email);
  };
  return (
    <div className="p-4">
      <h2 className="text-lg font-semibold mb-4">Contact Form</h2>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block font-medium">Name</label>
          <input
            type="text"
            className="w-full px-3 py-2 border rounded-lg"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
        </div>
        <div>
          <label className="block font-medium">Email</label>
          <input
            type="email"
            className="w-full px-3 py-2 border rounded-lg"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
        </div>
        <button
          type="submit"
          className="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600"
        >
          Submit
        </button>
      </form>
    </div>
  );
};

export default App;