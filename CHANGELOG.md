<a name="v0.5.0"></a>
# v0.5.0 (2014-05-29)

## :sparkles: Features

- Add extra easing curves presets ([fe74b2b8](https://github.com/abe33/atom-bezier-curve-editor/commit/fe74b2b852baaa9aa18d7606cba85863367bf1f2),  [#2](https://github.com/abe33/atom-bezier-curve-editor/issues/2))
  <br>Includes:
  - Cubic
  - Circ
  - Expo
  - Quad
  - Quart
  - Quint
  - Sine
  - Back

## :bug: Bug Fixes

- Fix placement of the popup when editor content is small ([244e7a25](https://github.com/abe33/atom-bezier-curve-editor/commit/244e7a256f5cfce45ace3fcf3d20a1b47869df4d), [#1](https://github.com/abe33/atom-bezier-curve-editor/issues/1))
- Fix typo leading to error in conditional context menu ([27c78c52](https://github.com/abe33/atom-bezier-curve-editor/commit/27c78c524daad005dc2f0666ed45848f139ff9ed))

<a name="v0.4.0"></a>
# v0.4.0 (2014-05-29)

## :bug: Bug Fixes

- Fixes weird behavior when using mouse to select text ([8baa136](https://github.com/abe33/atom-bezier-curve-editor/commit/8baa136cb134f05a129b209fc19aae2f2785c9ff))

<a name="v0.3.0"></a>
# v0.3.0 (2014-05-29)

## :sparkles: Features

- Adds an animated preview of the timing function ([f985edb0](https://github.com/abe33/atom-bezier-curve-editor/commit/f985edb060d743fad1faad88c3489b89036911fc))


<a name="v0.2.0"></a>
# v0.2.0 (2014-05-29)

## :sparkles: Features

- Adds proper icons for presets buttons ([e2169bdc](https://github.com/abe33/atom-bezier-curve-editor/commit/e2169bdcb1fcbe513a8c446f71788e6c5143e63b))
- Adds buttons to set spline using presets ([fa767067](https://github.com/abe33/atom-bezier-curve-editor/commit/fa7670674da77c9f76c385acc68b04ae9276b309))
  <br>The UI is quite broken though
- Adds a getModel method on the view ([21cbcad6](https://github.com/abe33/atom-bezier-curve-editor/commit/21cbcad6ff9f61ebc5796d37c40bd37e9d50cfef))
  <br>Not used, but seems to be required for views in the editor.