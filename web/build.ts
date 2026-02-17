export default await Bun.build({
  entrypoints: ['./ts/main.ts'],
  outdir: './dist',
  naming: '[name].js',
  minify: true,
  target: 'browser',
});

console.log('Build done!');
