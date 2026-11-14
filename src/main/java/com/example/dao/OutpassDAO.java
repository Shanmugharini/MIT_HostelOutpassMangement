import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OutpassDAO {
    public boolean deleteOutpass(String outpassId) {
        String query = "DELETE FROM outpass WHERE id = ?"; // Verify column name
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, outpassId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
