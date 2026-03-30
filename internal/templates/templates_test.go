package templates

import (
	"html/template"
	"testing"
)

func TestLinkTickets(t *testing.T) {
	tests := []struct {
		name string
		in   string
		want template.HTML
	}{
		{"plain text", "no tickets here", "no tickets here"},
		{"single ticket", "see SO-5 for details", `see <a href="/issues/SO-5" class="text-ac-t hover:underline">SO-5</a> for details`},
		{"multiple tickets", "SO-1 and SO-42", `<a href="/issues/SO-1" class="text-ac-t hover:underline">SO-1</a> and <a href="/issues/SO-42" class="text-ac-t hover:underline">SO-42</a>`},
		{"with newlines", "line1\nSO-3", `line1<br><a href="/issues/SO-3" class="text-ac-t hover:underline">SO-3</a>`},
		{"html escaped", "SO-1 <script>", `<a href="/issues/SO-1" class="text-ac-t hover:underline">SO-1</a> &lt;script&gt;`},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := linkTickets(tt.in)
			if got != tt.want {
				t.Errorf("linkTickets(%q)\n got: %s\nwant: %s", tt.in, got, tt.want)
			}
		})
	}
}
