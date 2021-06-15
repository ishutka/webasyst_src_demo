import { Validator } from 'vee-validate';
const requiredMessage = 'Это поле обязательно к заполнению';
const dictionary = {
  en: {
    messages: {
      email: () => 'Email введен не корректно',
      phone: () => 'Номер моб. введен не корректно',
      password: () => 'Пароль должен содержать больше 6 символов',
      alpha_dash: () =>
        'Для пароля используйте только буквенно-цифровые символы ',
      passwordConfirm: () => 'Пароли не совпадают',
    },
    custom: {
      email: {
        required: () => requiredMessage,
      },
      street: {
        required: () => requiredMessage,
      },
      phone: {
        required: () => requiredMessage,
      },
      name: {
        required: () => requiredMessage,
      },
      middlename: {
        required: () => requiredMessage,
      },
      password: {
        required: () => requiredMessage,
      },
      passwordConfirm: {
        required: () => requiredMessage,
      },
      message: {
        required: () => requiredMessage,
      },
    },
  },
};

Validator.extend('phone', {
  validate: value =>
    new Promise(resolve => {
      resolve({
        valid: !!value.match(
          /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im,
        ),
      });
    }),
});
Validator.extend('password', {
  validate: value =>
    new Promise(resolve => {
      resolve({
        valid: value.split('').length > 5,
      });
    }),
});
Validator.extend('passwordConfirm', {
  validate: (value, second) =>
    new Promise(resolve => {
      resolve({
        valid: value === second[0],
      });
    }),
});

Validator.localize(dictionary);
