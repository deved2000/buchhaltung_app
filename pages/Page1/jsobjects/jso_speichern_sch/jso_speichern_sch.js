export default {
    speichern: async () => {
        try {
            if (Table_sch.selectedRow?.sid != null && Table_sch.selectedRow?.sid !== "") {
                await update_rs_schuldner.run();
                await insertSchuldner.run();
                await getSchuldner.run();
                resetWidget('InputSchuldner');
                showAlert('Schuldner aktualisiert ✅', 'success');
                removeValue("");
            } else {
                await insertSchuldner.run();
                await getSchuldner.run();
                resetWidget('InputSchuldner');
                showAlert('Schuldner gespeichert ✅', 'success');
                removeValue("");
            }
        } catch (e) {
            showAlert('Fehler beim Speichern ❌', 'error');
        }
    }
}