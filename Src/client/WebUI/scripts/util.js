

function colorize(text, color) {
	return `\x1b[${color}m${text}\x1b[0m`;
}

//enum colors
const colors = {
	red: '31',
	green: '32',
	yellow: '33',
	blue: '34',
	magenta: '35',
	cyan: '36'
};

module.exports = {
	colorize, colors
};
