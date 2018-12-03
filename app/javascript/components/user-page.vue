<template>
.row.mt-2
  common
  .col-md-4.col-xs-16
    demo(:account="account")
  .col-md-5.col-xs-16
    h4 Timeline 
    <br>
    messages-list(:messages="messages")
  .col-md-3.col-xs-16
    h4 Thread following 
    <br>
</template>

<script>
Vue,component('profile-about', {
  template: '#profile-about'
})
export default {
  props: [
    'account',
    'messages'
  ],
  data() {
    return {
      currentAccount: window.currentAccount
    }
  },
  methods: {
    addMessage(message) {
      // do something
    }
  },
  mounted() {
  }
}
</script>

<style lang="sass" scoped>
$gutter: 30px
$half-gutter: 15px
$primary: #009688 
*, *:before, *:after
  box-sizing: border-box
body
  background: #fff
  background-image: url(http://p-hold.com/dock/1000/700/gray)
  background-size: cover
  background-position: top left
  font-family: 'Rubik', sans-serif
  p
    color: #424242
    line-height: 1.4
  h1, h2, h3
    text-transform: uppercase
    letter-spacing: 2px
img
  max-width: 100%
.container
  background: linear-gradient(to right bottom, transparent 50%, $primary 50%)
  height: 100vh
  width: 100%
.profile
  background-color: #fff
  box-shadow: 0 20px 75px darken($primary, 20%)
  position: absolute
  top: 50%
  left: 50%
  transform: translate(-50%, -50%)
  padding: 3em 
  width: 90%
  max-width: 800px
  min-width: 600px
  margin: 0 auto
  height: 550px
  .user-info
    width: calc(40% - #{$half-gutter})
    margin-right: $gutter
    float: left
    h2
      font-size: 2em
      font-weight: 100
    .user-info_avatar
      border: 5px solid $primary
    img, h3
      position: relative
      top: -15px
      left: -25px
  .profile_nav
    margin-top: 1em
    ul
      list-style: none
      padding-left: 1em
      border-left: 3px solid #eaeaea
    li
      margin-top: .5em
      font-size: 1.2em
      font-weight: bold
      letter-spacing: 2px
      transition: 0.2s all
      &.active
        color: $primary
      &:hover
        cursor: pointer
        color: $primary
  .content
    width: calc(60% - #{$half-gutter})
    max-height: 100%
    float: left
    h3
      margin-top: 0
      font-size: 1.8em
    .bg-float
      text-transform: capitalize
      color: rgba(230, 230, 230, 0.2)
      font-weight: bold
      position: absolute
      right: 10px
      bottom: 0
      font-size: 12em
      z-index: -1
.posts
  list-style: none
  li
    border-bottom: 1px solid #eaeaea
    margin-bottom: 1em
    padding: .25em
    &:after
      display: table
      content: ''
      clear: both
  img, h4
    display: inline-block
    margin-right: 1em
    float: left
//VUE transition classes
.slide-fade-enter-active, .slide-fade-leave-active 
  transition: opacity .1s, transform .2s

.slide-fade-enter, .slide-fade-leave-active 
  opacity: 0
  transform: translateX(20px)

</style>
