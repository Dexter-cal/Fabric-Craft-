// --- AI Chat Bubble Component ---

class AIChatBubble {
    constructor(containerId) {
        this.container = document.getElementById(containerId);
        this.render();
    }

    render() {
        this.container.innerHTML = `
            <div id="ai-bubble">
                <p id="ai-text">Hello! How can I help you design today?</p>
                <button id="replay-audio-btn">🔊</button>
            </div>
        `;
        this.audio = null;
    }

    displayMessage(text, audioData) {
        document.getElementById('ai-text').innerText = text;
        if (audioData) {
            // In a real app, this would handle playing the audio data.
            this.audio = audioData; // Store audio path/data
            console.log(`Playing audio for: "${text}"`);
        }
    }
}

// Initialize the AI chat bubble
const aiChatBubble = new AIChatBubble('ai-chat-bubble-container');
// Example usage:
// aiChatBubble.displayMessage("Here is the design you asked for.", "path/to/speech.wav");
