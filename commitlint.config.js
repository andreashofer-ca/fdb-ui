module.exports = {
    extends: ['@commitlint/config-conventional'],
    rules: {
        'header-max-length': [2, 'always', 120],
        'header-case': [0, 'always'], // Disable case checking
        'footer-max-line-length': [2, 'always', 200],
        'body-max-line-length': [0], // Disable body-max-line-length rule
    },
};
