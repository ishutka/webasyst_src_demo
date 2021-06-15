export default {
  data() {
    return {
      imgSrc: '',
      captchaError: '',
      captcha: '',
      baseCaptchaApp: 'shop',
    };
  },
  computed: {
    captchaApp() {
      return this.customCaptchaApp || this.baseCaptchaApp;
    },
  },
  created() {
    this.setNewImgSrc();
  },
  methods: {
    setNewImgSrc() {
      this.imgSrc = `/${this.captchaApp}/captcha.php?/rid=${Math.random()}`;
    },
    captchaRefresh() {
      this.setNewImgSrc();
      this.captcha = '';
      this.$refs.captcha_img.addEventListener('load', this.focusOnInput);
    },
    focusOnInput() {
      this.captchaError = '';
      this.$refs.captcha_input.focus();
    },
  },
};
