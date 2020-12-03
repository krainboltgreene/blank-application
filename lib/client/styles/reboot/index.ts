const reboot = `
@charset "UTF-8"; /*!
* Bootstrap v5.0.0-alpha3 (https://getbootstrap.com/)
* Copyright 2011-2020 The Bootstrap Authors
* Copyright 2011-2020 Twitter, Inc.
* Licensed under MIT (https://github.com/twbs/bootstrap/blob/main/LICENSE)
*/
:root {
    --bs-blue: #0d6efd;
    --bs-indigo: #6610f2;
    --bs-purple: #6f42c1;
    --bs-pink: #d63384;
    --bs-red: #dc3545;
    --bs-orange: #fd7e14;
    --bs-yellow: #ffc107;
    --bs-green: #198754;
    --bs-teal: #20c997;
    --bs-cyan: #0dcaf0;
    --bs-white: #fff;
    --bs-gray: #6c757d;
    --bs-gray-dark: #343a40;
    --bs-primary: #0d6efd;
    --bs-secondary: #6c757d;
    --bs-success: #198754;
    --bs-info: #0dcaf0;
    --bs-warning: #ffc107;
    --bs-danger: #dc3545;
    --bs-light: #f8f9fa;
    --bs-dark: #212529;
    --bs-font-sans-serif: system-ui, -apple-system, "Segoe UI", Roboto,
        "Helvetica Neue", Arial, "Noto Sans", "Liberation Sans", sans-serif,
        "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol",
        "Noto Color Emoji";
    --bs-font-monospace: SFMono-Regular, Menlo, Monaco, Consolas,
        "Liberation Mono", "Courier New", monospace;
    --bs-gradient: linear-gradient(
        180deg,
        rgba(255, 255, 255, 0.15),
        rgba(255, 255, 255, 0)
    );
}

*,
::after,
::before {
    box-sizing: border-box;
}

@media (prefers-reduced-motion: no-preference) {
    :root {
        scroll-behavior: smooth;
    }
}

body {
    margin: 0;
    font-family: var(--bs-font-sans-serif);
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #212529;
    background-color: #fff;
    -webkit-text-size-adjust: 100%;
    -webkit-tap-highlight-color: transparent;
}

[tabindex="-1"]:focus:not(:focus-visible) {
    outline: 0 !important;
}

hr {
    margin: 1rem 0;
    color: inherit;
    background-color: currentColor;
    border: 0;
    opacity: 0.25;
}

hr:not([size]) {
    height: 1px;
}

h1,
h2,
h3,
h4,
h5,
h6 {
    margin-top: 0;
    margin-bottom: 0.5rem;
    font-weight: 500;
    line-height: 1.2;
}

h1 {
    font-size: calc(1.375rem + 1.5vw);
}

@media (min-width: 1200px) {
    h1 {
        font-size: 2.5rem;
    }
}

h2 {
    font-size: calc(1.325rem + 0.9vw);
}

@media (min-width: 1200px) {
    h2 {
        font-size: 2rem;
    }
}

h3 {
    font-size: calc(1.3rem + 0.6vw);
}

@media (min-width: 1200px) {
    h3 {
        font-size: 1.75rem;
    }
}

h4 {
    font-size: calc(1.275rem + 0.3vw);
}

@media (min-width: 1200px) {
    h4 {
        font-size: 1.5rem;
    }
}

h5 {
    font-size: 1.25rem;
}

h6 {
    font-size: 1rem;
}

p {
    margin-top: 0;
    margin-bottom: 1rem;
}

abbr[data-original-title],
abbr[title] {
    text-decoration: underline;
    -webkit-text-decoration: underline dotted;
    text-decoration: underline dotted;
    cursor: help;
    -webkit-text-decoration-skip-ink: none;
    text-decoration-skip-ink: none;
}

address {
    margin-bottom: 1rem;
    font-style: normal;
    line-height: inherit;
}

ol,
ul {
    padding-left: 2rem;
}

dl,
ol,
ul {
    margin-top: 0;
    margin-bottom: 1rem;
}

ol ol,
ol ul,
ul ol,
ul ul {
    margin-bottom: 0;
}

dt {
    font-weight: 700;
}

dd {
    margin-bottom: 0.5rem;
    margin-left: 0;
}

blockquote {
    margin: 0 0 1rem;
}

b,
strong {
    font-weight: bolder;
}

small {
    font-size: 0.875em;
}

mark {
    padding: 0.2em;
    background-color: #fcf8e3;
}

sub,
sup {
    position: relative;
    font-size: 0.75em;
    line-height: 0;
    vertical-align: baseline;
}

sub {
    bottom: -0.25em;
}

sup {
    top: -0.5em;
}

a {
    color: #0d6efd;
    text-decoration: underline;
}

a:hover {
    color: #0a58ca;
}

a:not([href]):not([class]),
a:not([href]):not([class]):hover {
    color: inherit;
    text-decoration: none;
}

code,
kbd,
pre,
samp {
    font-family: var(--bs-font-monospace);
    font-size: 1em;
}

pre {
    display: block;
    margin-top: 0;
    margin-bottom: 1rem;
    overflow: auto;
    font-size: 0.875em;
}

pre code {
    font-size: inherit;
    color: inherit;
    word-break: normal;
}

code {
    font-size: 0.875em;
    color: #d63384;
    word-wrap: break-word;
}

a > code {
    color: inherit;
}

kbd {
    padding: 0.2rem 0.4rem;
    font-size: 0.875em;
    color: #fff;
    background-color: #212529;
    border-radius: 0.2rem;
}

kbd kbd {
    padding: 0;
    font-size: 1em;
    font-weight: 700;
}

figure {
    margin: 0 0 1rem;
}

img,
svg {
    vertical-align: middle;
}

table {
    caption-side: bottom;
    border-collapse: collapse;
}

caption {
    padding-top: 0.5rem;
    padding-bottom: 0.5rem;
    color: #6c757d;
    text-align: left;
}

th {
    text-align: inherit;
    text-align: -webkit-match-parent;
}

tbody,
td,
tfoot,
th,
thead,
tr {
    border-color: inherit;
    border-style: solid;
    border-width: 0;
}

label {
    display: inline-block;
}

button {
    border-radius: 0;
}

button:focus {
    outline: dotted 1px;
    outline: -webkit-focus-ring-color auto 5px;
}

button,
input,
optgroup,
select,
textarea {
    margin: 0;
    font-family: inherit;
    font-size: inherit;
    line-height: inherit;
}

button,
select {
    text-transform: none;
}

[role="button"] {
    cursor: pointer;
}

select {
    word-wrap: normal;
}

[list]::-webkit-calendar-picker-indicator {
    display: none;
}

[type="button"],
[type="reset"],
[type="submit"],
button {
    -webkit-appearance: button;
}

[type="button"]:not(:disabled),
[type="reset"]:not(:disabled),
[type="submit"]:not(:disabled),
button:not(:disabled) {
    cursor: pointer;
}

::-moz-focus-inner {
    padding: 0;
    border-style: none;
}

textarea {
    resize: vertical;
}

fieldset {
    min-width: 0;
    padding: 0;
    margin: 0;
    border: 0;
}

legend {
    float: left;
    width: 100%;
    padding: 0;
    margin-bottom: 0.5rem;
    font-size: calc(1.275rem + 0.3vw);
    line-height: inherit;
}

@media (min-width: 1200px) {
    legend {
        font-size: 1.5rem;
    }
}

legend + * {
    clear: left;
}

::-webkit-datetime-edit-day-field,
::-webkit-datetime-edit-fields-wrapper,
::-webkit-datetime-edit-hour-field,
::-webkit-datetime-edit-minute,
::-webkit-datetime-edit-month-field,
::-webkit-datetime-edit-text,
::-webkit-datetime-edit-year-field {
    padding: 0;
}

::-webkit-inner-spin-button {
    height: auto;
}

[type="search"] {
    outline-offset: -2px;
    -webkit-appearance: textfield;
}

::-webkit-search-decoration {
    -webkit-appearance: none;
}

::-webkit-color-swatch-wrapper {
    padding: 0;
}

::file-selector-button {
    font: inherit;
}

::-webkit-file-upload-button {
    font: inherit;
    -webkit-appearance: button;
}

output {
    display: inline-block;
}

iframe {
    border: 0;
}

summary {
    display: list-item;
    cursor: pointer;
}

progress {
    vertical-align: baseline;
}

[hidden] {
    display: none !important;
}

@-webkit-keyframes progress-bar-stripes {
    0% {
        background-position-x: 1rem;
    }
}

@keyframes progress-bar-stripes {
    0% {
        background-position-x: 1rem;
    }
}

@-webkit-keyframes spinner-border {
    to {
        transform: rotate(360deg);
    }
}

@keyframes spinner-border {
    to {
        transform: rotate(360deg);
    }
}

@-webkit-keyframes spinner-grow {
    0% {
        transform: scale(0);
    }

    50% {
        opacity: 1;
        transform: none;
    }
}

@keyframes spinner-grow {
    0% {
        transform: scale(0);
    }

    50% {
        opacity: 1;
        transform: none;
    }
}
`;

export default reboot;
