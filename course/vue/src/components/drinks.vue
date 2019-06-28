<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
  <div class="hello">
    <img @click="get_all_drinks" src="../assets/logo.png">
    <v-spacer></v-spacer>
    <v-flex>

    </v-flex>
    <v-layout row wrap align-center>
      <v-spacer></v-spacer>
      <v-flex xs3>
        <v-text-field
          v-model="search"
          append-icon="search"
          label="Search"
          single-line
          hide-details
        ></v-text-field>
      </v-flex>
      <v-spacer></v-spacer>
      <v-dialog
        attach v-model="dialog" persistent max-width="600px">
        <template v-slot:activator="{ on }">
          <v-btn color="primary" dark class="mb-2" v-on="on">New Item</v-btn>
        </template>
        <v-card>
          <v-card-title>
            <span class="headline">{{ formTitle }}</span>
          </v-card-title>
          <v-card-text>
            <v-form v-model="valid">
              <v-container grid-list-md>
                <v-layout wrap>
                  <v-flex xs12 sm6 md4>
                    <v-text-field v-model="editedItem.title" label="Title" :rules="titleRules" required></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm6 md4>
                    <v-text-field v-model="editedItem.volume" label="Volume" :rules="numberRules"
                                  type="number"></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm6 md4>
                    <v-text-field v-model="editedItem.rating" label="Rating" :rules="ratingRules"
                                  type="number"></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm6 md4>
                    <v-text-field v-model="editedItem.alcohol" label="Alcohol" :rules="numberRules"
                                  type="number"></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm6 md4>
                    <v-text-field v-model="editedItem.average_price" label="Average price" :rules="numberRules"
                                  type="number"></v-text-field>
                  </v-flex>
                  <v-flex xs12 sm6 md4>
                    <v-select
                      v-model="editedItem.drink_type"
                      :items="drink_types"
                      label="Drink type"
                      single-line
                    ></v-select>
                  </v-flex>
                </v-layout>
              </v-container>
            </v-form>
          </v-card-text>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue darken-1" flat @click="close">Cancel</v-btn>
            <v-btn color="blue darken-1" flat @click="save">Save</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
      <v-spacer></v-spacer>
      <v-flex xs3>
        <v-select
          v-model="filtering_type"
          :items="drink_types"
          attach
          label="Drink type"
          single-line
          @change="filter_by_type(filtering_type)"
        ></v-select>
      </v-flex>
      <v-spacer></v-spacer>
    </v-layout>
    <v-toolbar flat color="white">
      <v-toolbar-title>Drinks</v-toolbar-title>
      <v-spacer></v-spacer>
    </v-toolbar>
    <v-divider
      class="mx-2"
      inset
      vertical
    ></v-divider>
    <v-spacer></v-spacer>
    <v-data-table
      :headers="headers"
      :items="drinks"
      :pagination.sync="pagination"
      :rows-per-page-items="pagination.rowsPerPageItems"
      :expand="expand"
      :search="search"
      item-key="drink_id"
      class="elevation-1"
    >
      <template v-slot:items="props">
        <tr
          @click="get_components(props.item.drink_id); get_places(props.item.drink_id); props.expanded = !props.expanded">
          <td class="text-xs-left">{{ props.item.title }}</td>
          <td class="text-xs-left">{{ round(props.item.rating) }}</td>
          <td class="text-xs-left">{{ round(props.item.volume) }}</td>
          <td class="text-xs-left">{{ round(props.item.alcohol) }}</td>
          <td class="text-xs-left">{{ round(props.item.average_price) }}</td>
          <td class="text-xs-left">{{ props.item.drink_type }}</td>
          <td class="justify-left">
            <v-icon
              small
              class="mr-2"
              v-on:click.stop="editItem(props.item)"
            >
              edit
            </v-icon>
            <v-icon
              small
              v-on:click.stop="deleteItem(props.item)"
            >
              delete
            </v-icon>
          </td>
        </tr>
      </template>
      <template v-slot:expand="props">
        <v-card flat>
          <v-card-text>Components:
            <li v-for="component in components" style="color: darkgrey">
              {{component.title}}
            </li>
          </v-card-text>
          <v-card-text>Places:
            <div v-for="place in places" style="color: darkgrey" class="text-md-center">
              <li>
                {{place.title}} по адресу {{place.address}}
              </li>
            </div>
          </v-card-text>
        </v-card>
      </template>
      <template v-slot:no-data="props">
        <v-alert :value="true" color="#000000" icon="warning">
          Sorry, nothing to display here :(
        </v-alert>
      </template>
    </v-data-table>
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    name: 'Drinks',
    data() {
      return {
        expand: false,
        dialog: false,
        valid: false,
        drinks: [],
        components: [],
        places: [],
        search: '',
        filtering_type: '',
        editing_type: '',
        titleRules: [
          v => !!v || 'Title is required',
          v => v.length <= 50 || 'Title must be less than 10 characters'
        ],
        ratingRules: [
          v => !!v || 'Rating must not be empty',
          v => v <= 10 || 'Rating must be in 0..10',
          v => v >= 0 || 'Rating must be in 0..10'
        ],
        numberRules: [
          v => !!v || 'Number must not be null',
          v => v >= 0 || 'Number must positive'
        ],

        drink_types: [
          'пиво и сидр',
          'водка и настойки',
          'ром',
          'текила',
          'виски',
          'биттеры',
          'вино',
          'бренди и коньяк',
          'шоты',
          'коктейли',
          'безалкогольные'
        ],
        headers: [
          {
            text: 'Drink title',
            align: 'left',
            sortable: true,
            value: 'title'
          },
          {text: 'Rating', value: 'rating'},
          {text: 'Volume', value: 'volume'},
          {text: 'Alcohol (%)', value: 'alcohol'},
          {text: 'Average price', value: 'average_price'},
          {text: 'Drink type', value: 'drink_type'},
          {text: 'Actions', value: 'name', sortable: false}
        ],
        pagination: {
          descending: true,
          page: 1,
          rowsPerPage: 10,
          totalItems: 0,
          rowsPerPageItems: [10]
        },
        editedIndex: -1,
        editedItem: {
          title: '',
          rating: 0,
          volume: 0,
          alcohol: 0,
          average_price: 0,
          drink_type: ''
        },
        defaultItem: {
          title: '',
          rating: 0,
          volume: 0,
          alcohol: 0,
          average_price: 0
        }
      }
    },

    computed: {
      formTitle() {
        return this.editedIndex === -1 ? 'New Item' : 'Edit Item'
      }
    },

    watch: {
      dialog(val) {
        val || this.close()
      }
    },

    methods: {
      get_all_drinks: function () {
        const self = this;
        axios({
          method: 'get',
          url: 'http://localhost:3000/api/all_drinks'
        }).then((drinks) => {
          self.drinks = drinks.data
        })
      },
      get_components: function (drink_id) {
        const self = this
        axios({
          method: 'get',
          url: `http://localhost:3000/api/components?drink_id=${drink_id}`
        }).then((components) => {
          self.components = components.data
        })
      },
      get_places: function (drink_id) {
        const self = this
        axios({
          method: 'get',
          url: `http://localhost:3000/api/places?drink_id=${drink_id}`
        }).then((places) => {
          self.places = places.data
        })
      },
      editItem(item) {
        this.editedIndex = this.drinks.indexOf(item)
        this.editedItem = Object.assign({}, item)
        this.dialog = true
      },
      deleteItem(item) {
        const index = this.drinks.indexOf(item)
        confirm('Are you sure you want to delete this item?') && this.drinks.splice(index, 1) && axios({
          method: 'delete',
          url: `http://localhost:3000/api/delete_drink?drink_id=${item.drink_id}`
        }).then((drinks) => {
          self.drinks = drinks.data
        })
      },

      close() {
        this.dialog = false
        setTimeout(() => {
          this.editedItem = Object.assign({}, this.defaultItem)
          this.editedIndex = -1
        }, 300)
      },
      save() {
        if (this.editedItem.title !== ''
          && this.editedItem.alcohol >= 0 && this.editedItem.alcohol !== ''
          && this.editedItem.volume >= 0 && this.editedItem.volume !== ''
          && this.editedItem.average_price >= 0 && this.editedItem.average_price !== ''
          && this.editedItem.rating >= 0 && this.editedItem.rating <= 10 && this.editedItem.rating !== ''
          && this.editedItem.drink_type !== ''
        ) {
          if (this.editedIndex > -1) {
            const drink = this.drinks[this.editedIndex];
            Object.assign(drink, this.editedItem);
            axios({
              method: 'post',
              url: `http://localhost:3000/api/edit_drink?drink_id=${drink.drink_id}&title=${drink.title}&rating=${drink.rating}&volume=${drink.volume}&alcohol=${drink.alcohol}&average_price=${drink.average_price}&drink_type=${drink.drink_type}`
            }).then((drinks) => {
              self.drinks = drinks.data
            })
          } else {
            this.drinks.push(this.editedItem);
            const drink = this.editedItem;
            axios({
              method: 'post',
              url: `http://localhost:3000/api/new_drink?title=${drink.title}&rating=${drink.rating}&volume=${drink.volume}&alcohol=${drink.alcohol}&average_price=${drink.average_price}&drink_type=${drink.drink_type}`
            }).then((drinks) => {
              self.drinks = drinks.data
            })
          }
          this.close()
        }
      },
      round: (number) => Math.round(number * 100) / 100,
      filter_by_type(val) {
        const self = this;
        axios({
          method: 'get',
          url: 'http://localhost:3000/api/all_drinks'
        }).then((drinks) => {
          self.drinks = drinks.data;
          self.drinks = self.drinks.filter(el => el.drink_type === val)
        });
      }
    }

  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  h1, h2 {
    font-weight: normal;
  }

  ul {
    list-style-type: none;
    padding: 0;
  }

  li {
    display: inline-block;
    margin: 0 10px;
  }

  a {
    color: #42b983;
  }
</style>
