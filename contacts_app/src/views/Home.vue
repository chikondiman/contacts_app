<template>
  <div class="home">
    <h1>{{ message }}</h1>
    <h2>{{ message2 }}</h2>
    <div v-bind:key="contact.id" v-for="contact in contacts">
      <p>id: {{ contact.id }}</p>
      <p>title: {{ contact.title }}</p>
      <p>ingredients: {{ contact.ingredients }}</p>
      <p>image url: {{ contact.image_url }}</p>
      <button v-on:click="showInfo(contact)">Show more info</button>
      <div v-if="currentContact === contact"></div>
    </div>
  </div>
</template>

<style>
</style>

<script>
export default {
  data: function() {
    return {
      message: "'e-mail goon-app' --cold e-mail the galaxies",
      message2: "chikondiman for Hokage!",
      name: this.ContactName
  };
},
  created: function() {},
  methods: {
    addContact: function() {

axios.post("/api/contacts", params).then(response => {
        console.log(response.data);
        this.contacts.push(response.data)
        this.newContactName = "";
)}
  },
};
</script>
