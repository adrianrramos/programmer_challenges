package com.simplekafka.broker;

import java.io.IOException;
import java.util.concurrent.CountDownLatch;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.ZooDefs;
import org.apache.zookeeper.ZooKeeper;

public class ZookeeperClient {
    private static final Logger LOGGER = Logger.getLogger(ZookeeperClient.class.getName());
    private static final int SESSION_TIMEOUT = 30000;

    private final String host;
    private final int port;
    private ZooKeeper zooKeeper;
    private CountDownLatch connectedSignal = new CountDownLatch(1);

    public void connect() throws IOException, InterruptedException {
        zooKeeper = new ZooKeeper(getConnectString(), SESSION_TIMEOUT, this);
        connectedSignal.await();

        // Create required paths if they don't exist
        createPath("/brokers");
        createPath("/topics");
        createPath("/controller");
    }

    /**
     * Get connection string
     */
    public String getConnectString() {
        return host + ":" + port;
    }

    /**
     * Create a path recursively
     */
    private void createPath(String path) {
        try {
            if (path.equals("/")) {
                return;
            }

            int lastSlashIndex = path.lastIndexOf('/');
            if (lastSlashIndex > 0) {
                // Create parent path recursively
                String parentPath = path.substring(0, lastSlashIndex);
                createPath(parentPath);
            }

            if (zooKeeper.exists(path, false) == null) {
                zooKeeper.create(path, new byte[0], ZooDefs.Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
                LOGGER.info("Created Zookeeper path: " + path, e);
            }

        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Failed to create path: " + path, e);
        }
    }

}
