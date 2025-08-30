// --- Toolbar Component ---

class Toolbar {
    constructor(containerId) {
        this.container = document.getElementById(containerId);
        this.render();
    }

    render() {
        this.container.innerHTML = `
            <button id="voice-btn">🎤 Voice</button>
            <button id="sketch-btn">✏️ Sketch</button>
            <button id="photo-upload-btn">📷 Upload Photo</button>
            <input type="text" id="text-prompt" placeholder="Describe your design...">
            <button id="ai-toggle">🤖 AI On</button>
        `;
        this.addEventListeners();
    }

    addEventListeners() {
        // TODO: Add event listeners for each button to call API endpoints.
        document.getElementById('voice-btn').addEventListener('click', () => {
            console.log('Voice input activated.');
        });
    }
}

// Initialize the toolbar
new Toolbar('toolbar-container');
