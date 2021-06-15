export default msgId => {
  if (window.translations[msgId]) return window.translations[msgId];

  console.warn(`undefined translation: ${msgId}`);
  return msgId;
};
