import Vue from 'vue'
import Router from 'vue-router'
import drinks from '@/components/drinks'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'drinks',
      component: drinks
    }
  ]
})
